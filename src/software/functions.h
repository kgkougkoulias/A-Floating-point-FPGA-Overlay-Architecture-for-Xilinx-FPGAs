// stencil
void stencil();
void cpu_stencil(float c0, float c1, float *A0, float *Anext, const int nx, const int ny, const int nz);
void cpu_stencil_dyser(float c0, float c1, float *A0, float *Anext, const int nx, const int ny, const int nz);
void stencil_ovrl_less_idle(float c0, float c1, float *A0, float *Anext, const int nx, const int ny, const int nz);
// mm
void mm_v2();
void mm_cpu(int m, int n, int k, float alpha, float *A, int lda, float *B, int ldb, float beta, float *C, int ldc);
void dyser_mm(int m, int n, int k, float alpha, float *A, int lda, float *B, int ldb, float beta, float *C, int ldc);
void dyser_mm_less_idle(int m, int n, int k, float alpha, float *A, int lda, float *B, int ldb, float beta, float *C, int ldc);
void dyser_mm_less_idle_64(int m, int n, int k, float alpha, float *A, int lda, float *B, int ldb, float beta, float *C, int ldc);
// kmeans
void kmeans();
void kmeans_impl(int dim, float *X, int n, int k, float *clusster_centroid, int *cluster_assignment_final, char *alg);
// convolution
void conv();
void conv_cpu(float *y, float *x, float *h, uint32_t size);
void conv_ovrl(float *y, float *x, float *h, uint32_t size);
// algorithms top level
void cpu_algorithms(char *alg);
