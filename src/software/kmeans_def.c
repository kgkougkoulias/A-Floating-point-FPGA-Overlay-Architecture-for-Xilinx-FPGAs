#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>
#include <string.h>
#include "platform.h"
#include "xil_printf.h"
#include "xil_io.h"
#include "xtime_l.h"
#include "drivers_v2.h"
#include "sleep.h"
#include "xil_cache.h"
#include "functions.h"
#include <math.h>

//float d0[80];
float *d0;
float *d1;
char  *type;

#define sqr(x) ((x)*(x))

#define MAX_CLUSTERS 30

#define MAX_ITERATIONS 30

#define BIG_double (INFINITY)

void fail(char *str)
  {
    printf("str");
    exit(-1);
  }

float calc_distance(int dim, float *p1, float *p2)
  {
    float distance_sq_sum = 0;
    int ii;

    for ( ii = 0; ii < dim; ii++)
      distance_sq_sum += sqr(p1[ii] - p2[ii]);


    return distance_sq_sum;

  }

float calc_distance_ovrl_small(int dim, float *p1, float *p2)
  {

	//d1[0]  = 0;       	d1[1]  = 0;
	d1[2]  = p1[0]; 	d1[3]  = p2[0];
	d1[4]  = p1[1];   	d1[5]  = p2[1];
	d1[6]  = p1[2]; 	d1[7]  = p2[2];
	d1[8]  = p1[3]; 	d1[9]  = p2[3];
	//d1[10] = 0; 		d1[11] = 0;
	d1[12] = p1[4]; 	d1[13] = p2[4];
	d1[14] = p1[5]; 	d1[15] = p2[5];
	d1[16] = p1[6]; 	d1[17] = p2[6];
	d1[18] = p1[7]; 	d1[19] = p2[7];

    return kernel_5x5_less_idle_small(d1);

  }

void calc_distance_ovrl(int dim, float *p1, float *p2, float *res)
  {
    uint32_t i;

    for(i=0;i<4;i++){

    	//d0[i*20 + 0]  = 0;       	d0[i*20 + 1]  = 0;
		d0[i*20 + 2]  = p1[0]; 		d0[i*20 + 3]  = p2[dim*i + 0];
		d0[i*20 + 4]  = p1[1];   	d0[i*20 + 5]  = p2[dim*i + 1];
		d0[i*20 + 6]  = p1[2]; 		d0[i*20 + 7]  = p2[dim*i + 2];
		d0[i*20 + 8]  = p1[3]; 		d0[i*20 + 9]  = p2[dim*i + 3];
		//d0[i*20 + 10] = 0; 			d0[i*20 + 11] = 0;
		d0[i*20 + 12] = p1[4]; 		d0[i*20 + 13] = p2[dim*i + 4];
		d0[i*20 + 14] = p1[5]; 		d0[i*20 + 15] = p2[dim*i + 5];
		d0[i*20 + 16] = p1[6]; 		d0[i*20 + 17] = p2[dim*i + 6];
		d0[i*20 + 18] = p1[7]; 		d0[i*20 + 19] = p2[dim*i + 7];
    }

    Xil_DCacheFlushRange((unsigned int)d0, 320);
	Xil_Out32(CMDA_BTT, 0x00000140); 				// number of bytes to send


    kernel_5x5_less_idle(d0, res);

  }

void calc_all_distances(int dim, int n, int k, float *X, float *centroid, float *distance_output)
  {
	int ii, jj;
	uint32_t i;

    for (ii = 0; ii < n; ii++) {// for each point

    	if(strcmp(type, "cpu") == 0){
		  for (jj = 0; jj < k; jj++) {// for each cluster
			 // calculate distance between point and cluster centroid
			 distance_output[ii*k + jj] = calc_distance(dim, &X[ii*dim], &centroid[jj*dim]);
			 //printf("\naddress is %08X\n",(uint32_t)&distance_output[ii*k + jj]);
			 //usleep(5800000);
		  }
    	}
		else if(strcmp(type, "ovrl") == 0){



			for (jj = 0; jj < k; jj=jj+4) {// for each cluster
			//for (jj = 0; jj < k; jj++) {// for each cluster
			 // calculate distance between point and cluster centroid


			 calc_distance_ovrl(dim, &X[ii*dim], &centroid[jj*dim], &distance_output[ii*k+jj]);
			 //distance_output[ii*k + jj] = calc_distance_ovrl_small(dim, &X[ii*dim], &centroid[jj*dim]);


			}
		}
    }

 }

float calc_total_distance(int dim, int n, int k, float *X, float *centroids, int *cluster_assignment_index)
 // NOTE: a point with cluster assignment -1 is ignored
  {
    float tot_D = 0;
    int ii;

   // for every point
    for (ii = 0; ii < n; ii++)
      {
       // which cluster is it in?
        int active_cluster = cluster_assignment_index[ii];

       // sum distance
        if (active_cluster != -1)
           tot_D += calc_distance(dim, &X[ii*dim], &centroids[active_cluster*dim]);


      }

    return tot_D;
  }

void choose_all_clusters_from_distances(int dim, int n, int k, float *distance_array, int *cluster_assignment_index)
  {
   // for each point
	int ii, jj;


    for (ii = 0; ii < n; ii++)
      {
        int best_index = -1;
        float closest_distance = BIG_double;

       // for each cluster
        for (jj = 0; jj < k; jj++)
          {
           // distance between point and cluster centroid

            float cur_distance = distance_array[ii*k + jj];
            if (cur_distance < closest_distance)
              {
                best_index = jj;
                closest_distance = cur_distance;
              }
          }

       // record in array
        cluster_assignment_index[ii] = best_index;
      }
  }

void calc_cluster_centroids(int dim, int n, int k, float *X, int *cluster_assignment_index, float *new_cluster_centroid)
  {
    int cluster_member_count[MAX_CLUSTERS];
    int ii, jj;

   // initialize cluster centroid coordinate sums to zero
    for (ii = 0; ii < k; ii++)
      {
        cluster_member_count[ii] = 0;

        for (jj = 0; jj < dim; jj++)
          new_cluster_centroid[ii*dim + jj] = 0;
     }

   // sum all points
   // for every point
    for (ii = 0; ii < n; ii++)
      {
       // which cluster is it in?
        int active_cluster = cluster_assignment_index[ii];

       // update count of members in that cluster
        cluster_member_count[active_cluster]++;

       // sum point coordinates for finding centroid
        for (jj = 0; jj < dim; jj++)
          new_cluster_centroid[active_cluster*dim + jj] += X[ii*dim + jj];
      }


   // now divide each coordinate sum by number of members to find mean/centroid
   // for each cluster
    for (ii = 0; ii < k; ii++)
      {
        if (cluster_member_count[ii] == 0)
          printf("WARNING: Empty cluster %d! \n", ii);

       // for each dimension
        for (jj = 0; jj < dim; jj++)
          new_cluster_centroid[ii*dim + jj] /= cluster_member_count[ii];  /// XXXX will divide by zero here for any empty clusters!

      }
  }

void get_cluster_member_count(int n, int k, int *cluster_assignment_index, int *cluster_member_count)
  {
   // initialize cluster member counts
	int ii;

    for (ii = 0; ii < k; ii++)
      cluster_member_count[ii] = 0;

   // count members of each cluster
    for (ii = 0; ii < n; ii++)
      cluster_member_count[cluster_assignment_index[ii]]++;
  }

void update_delta_score_table(int dim, int n, int k, double *X, int *cluster_assignment_cur, float *cluster_centroid, int *cluster_member_count, float *point_move_score_table, int cc)
  {
   // for every point (both in and not in the cluster)
	int ii, kk;

    for (ii = 0; ii < n; ii++)
      {
        double dist_sum = 0;
        for (kk = 0; kk < dim; kk++)
          {
            float axis_dist = X[ii*dim + kk] - cluster_centroid[cc*dim + kk];
            dist_sum += sqr(axis_dist);
          }

        float mult = ((float)cluster_member_count[cc] / (cluster_member_count[cc] + ((cluster_assignment_cur[ii]==cc) ? -1 : +1)));

        point_move_score_table[ii*dim + cc] = dist_sum * mult;
      }
  }


void  perform_move(int dim, int n, int k, double *X, int *cluster_assignment, float *cluster_centroid, int *cluster_member_count, int move_point, int move_target_cluster)
  {
    int cluster_old = cluster_assignment[move_point];
    int cluster_new = move_target_cluster;
    int ii;

   // update cluster assignment array
    cluster_assignment[move_point] = cluster_new;

   // update cluster count array
    cluster_member_count[cluster_old]--;
    cluster_member_count[cluster_new]++;

    if (cluster_member_count[cluster_old] <= 1)
      printf("WARNING: Can't handle single-member clusters! \n");

   // update centroid array
    for (ii = 0; ii < dim; ii++)
      {
        cluster_centroid[cluster_old*dim + ii] -= (X[move_point*dim + ii] - cluster_centroid[cluster_old*dim + ii]) / cluster_member_count[cluster_old];
        cluster_centroid[cluster_new*dim + ii] += (X[move_point*dim + ii] - cluster_centroid[cluster_new*dim + ii]) / cluster_member_count[cluster_new];
      }
  }

void cluster_diag(int dim, int n, int k, float *X, int *cluster_assignment_index, float *cluster_centroid)
  {
    int cluster_member_count[MAX_CLUSTERS];
    int ii;

    get_cluster_member_count(n, k, cluster_assignment_index, cluster_member_count);

    printf("  Final clusters \n");
    for (ii = 0; ii < k; ii++)
      printf("    cluster %d:     members: %8d, centroid (%.1f %.1f) \n", ii, cluster_member_count[ii], cluster_centroid[ii*dim + 0], cluster_centroid[ii*dim + 1]);
  }

void copy_assignment_array(int n, int *src, int *tgt)
  {
	int ii;

    for (ii = 0; ii < n; ii++)
      tgt[ii] = src[ii];
  }

int assignment_change_count(int n, int a[], int b[])
  {
    int change_count = 0;
    int ii;

    for (ii = 0; ii < n; ii++)
      if (a[ii] != b[ii])
        change_count++;

    return change_count;
  }

void kmeans_impl(
            int  dim,		                     // dimension of data

            float *X,                        // pointer to data
            int   n,                         // number of elements

            int   k,                         // number of clusters
            float *cluster_centroid,         // initial cluster centroids
            int   *cluster_assignment_final, // output
			char  *alg
           )
  {

	uint32_t i;
    float *dist                    = (float *)malloc(sizeof(float) * n * k);
    int   *cluster_assignment_cur   = (int *)malloc(sizeof(int) * n);
    int   *cluster_assignment_prev = (int *)malloc(sizeof(int) * n);
    float *point_move_score        = (float *)malloc(sizeof(float) * n * k);

    type = alg;

    d0 = (float*)malloc(sizeof(float)*80);
    //d1 = (float*)malloc(sizeof(float)*20);

    for(i=0;i<4;i++){

      	d0[i*20 + 0]  = 0;       	d0[i*20 + 1]  = 0;
   		d0[i*20 + 10] = 0; 			d0[i*20 + 11] = 0;
    }



	//d1[0]  = 0;       	d1[1]  = 0;
	//d1[10] = 0; 		d1[11] = 0;


    if(strcmp(type, "ovrl") == 0){
    	program_cdma((uint32_t)d0, OVRL_PORT0); // initiate cdma (source, destination)
    }

    if (!dist || !cluster_assignment_cur || !cluster_assignment_prev || !point_move_score)
      fail("Error allocating dist arrays");

   // initial setup
    calc_all_distances(dim, n, k, X, cluster_centroid, dist);
    choose_all_clusters_from_distances(dim, n, k, dist, cluster_assignment_cur);
    copy_assignment_array(n, cluster_assignment_cur, cluster_assignment_prev);

   // BATCH UPDATE
    float prev_totD = BIG_double;
    int batch_iteration = 0;
    while (batch_iteration < MAX_ITERATIONS)
      {
//        printf("batch iteration %d \n", batch_iteration);
//        cluster_diag(dim, n, k, X, cluster_assignment_cur, cluster_centroid);

        // update cluster centroids
         calc_cluster_centroids(dim, n, k, X, cluster_assignment_cur, cluster_centroid);

        // deal with empty clusters
        // XXXXXXXXXXXXXX

        // see if we've failed to improve
         float totD = calc_total_distance(dim, n, k, X, cluster_centroid, cluster_assignment_cur);
         if (totD > prev_totD)
          // failed to improve - currently solution worse than previous
           {
            // restore old assignments
             copy_assignment_array(n, cluster_assignment_prev, cluster_assignment_cur);

            // recalc centroids
             calc_cluster_centroids(dim, n, k, X, cluster_assignment_cur, cluster_centroid);

             printf("  negative progress made on this step - iteration completed (%.2f) \n", totD - prev_totD);

            // done with this phase
             break;
           }

        // save previous step
         copy_assignment_array(n, cluster_assignment_cur, cluster_assignment_prev);

        // move all points to nearest cluster
         calc_all_distances(dim, n, k, X, cluster_centroid, dist);
         choose_all_clusters_from_distances(dim, n, k, dist, cluster_assignment_cur);

         int change_count = assignment_change_count(n, cluster_assignment_cur, cluster_assignment_prev);

         printf("%3d   %u   %9d  %16.2f %17.2f\n", batch_iteration, 1, change_count, totD, totD - prev_totD);
         fflush(stdout);

        // done with this phase if nothing has changed
         if (change_count == 0)
           {
             printf("  no change made on this step - iteration completed \n");
             break;
           }

         prev_totD = totD;

         batch_iteration++;
      }

   cluster_diag(dim, n, k, X, cluster_assignment_cur, cluster_centroid);

    // Added code for debugging
    //for(ii=0;ii<n;ii++){
    //    printf("Point[%d] = (%.2f ,%.2f) belongs to cluster %d \n", ii, X[ii*dim], X[ii*dim+1], cluster_assignment_cur[ii]);
    //}
    // End of added code


   // ONLINE UPDATE
/* The online update prtion of this code has never worked properly, but batch update has been adequate for our projects so far.
    int online_iteration = 0;
    int last_point_moved = 0;

    int cluster_changed[MAX_CLUSTERS];
    for (int ii = 0; ii < k; ii++)
      cluster_changed[ii] = 1;

    int cluster_member_count[MAX_CLUSTERS];
    get_cluster_member_count(n, k, cluster_assignment_cur, cluster_member_count);

    while (online_iteration < MAX_ITERATIONS)
      {
//        printf("online iteration %d \n", online_iteration);

       // for each cluster
        for (int ii = 0; ii < k; ii++)
          if (cluster_changed[ii])
            update_delta_score_table(dim, n, k, X, cluster_assignment_cur, cluster_centroid, cluster_member_count, point_move_score, ii);

       // pick a point to move
       // look at points in sequence starting at one after previously moved point
        int make_move = 0;
        int point_to_move = -1;
        int target_cluster = -1;
        for (int ii = 0; ii < n; ii++)
          {
            int point_to_consider = (last_point_moved + 1 + ii) % n;

           // find the best target for it
            int best_target_cluster = -1;
            int best_match_count    = 0;
            double best_delta        = BIG_double;

           // for each possible target
            for (int jj = 0; jj < k; jj++)
              {
                double cur_delta = point_move_score[point_to_consider*k + jj];

               // is this the best move so far?
                if (cur_delta < best_delta)
                 // yes - record it
                  {
                    best_target_cluster = jj;
                    best_delta = cur_delta;
                    best_match_count = 1;
                  }
                else if (cur_delta == best_delta)
                 // no, but it's tied with the best one
                 best_match_count++;
              }

           // is the best cluster for this point its current cluster?
            if (best_target_cluster == cluster_assignment_cur[point_to_consider])
             // yes - don't move this point
               continue;

           // do we have a unique best move?
            if (best_match_count > 1)
             // no - don't move this point (ignore ties)
              continue;
            else
             // yes - we've found a good point to move
              {
                point_to_move = point_to_consider;
                target_cluster = best_target_cluster;
                make_move = 1;
                break;
              }
          }

        if (make_move)
          {
           // where should we move it to?
            printf("  %10d: moved %d to %d \n", point_to_move, cluster_assignment_cur[point_to_move], target_cluster);

           // mark which clusters have been modified
            for (int ii = 0; ii < k; ii++)
              cluster_changed[ii] = 0;
            cluster_changed[cluster_assignment_cur[point_to_move]] = 1;
            cluster_changed[target_cluster] = 1;

           // perform move
            perform_move(dim, n, k, X, cluster_assignment_cur, cluster_centroid, cluster_member_count, point_to_move, target_cluster);

           // count an iteration every time we've cycled through all the points
            if (point_to_move < last_point_moved)
              online_iteration++;

            last_point_moved = point_to_move;
          }

      }

*/

//    printf("iterations: %3d %3d \n", batch_iteration, online_iteration);

   // write to output array
    copy_assignment_array(n, cluster_assignment_cur, cluster_assignment_final);

    free(dist);
    free(cluster_assignment_cur);
    free(cluster_assignment_prev);
    free(point_move_score);
  }
