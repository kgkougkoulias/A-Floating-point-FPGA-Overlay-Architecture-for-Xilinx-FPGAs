import re

# physical placement of switches and tiles
# sw0   sw1  sw2  sw3  sw4  sw5
# sw6   t0   t1   t2   t3   t4
# sw7   t5   t6   t7   t8   t9
# sw8   t10  t11  t12  t13  t14
# sw9   t15  t16  t17  t18  t19
# sw10  t20  t21  t22  t23  t24   

switches = []
tiles = []
conf_seq_reverse = []
conf_seq_str = ""
pattern = ""

# read the file that contains programming of the values for each register
conf_file = open("conf.txt", "r", encoding = "utf-8")
conf_str = conf_file.read()
conf_file.close()
split = conf_str.splitlines()

# read switches configurations based on a regular expression
for i in range(0,11):
	sw = "sw%d" %(i)
	pattern = '^' + sw + " = 0x(.+)$"  
	for smt in split:
		if re.search(pattern, smt):
			conf = re.findall(pattern, smt)
			switches.append(conf[0])

# read tiles configurations based on a regular expression
for i in range(0,25):
	t = "t%d" %(i)
	pattern = '^' + t + " = 0x(.+)$"  
	for smt in split:
		if re.search(pattern, smt):
			conf = re.findall(pattern, smt)
			tiles.append(conf[0])

# programming sequence as a list with respect to order that 
# each tile is programmed in reverse
conf_seq = [switches[10], tiles[20], tiles[21], tiles[22], tiles[23], tiles[24],
		tiles[19], tiles[18], tiles[17], tiles[16], tiles[15], switches[9],
		switches[8], tiles[10], tiles[11], tiles[12], tiles[13], tiles[14],
		tiles[9], tiles[8], tiles[7], tiles[6], tiles[5], switches[7],
		switches[6], tiles[0], tiles[1], tiles[2], tiles[3], tiles[4],
		switches[5], switches[4], switches[3], switches[2], switches[1], switches[0]]


# convert list to string
for item in conf_seq:
	conf_seq_str += item
conf_seq_str += "0000"

# reverse conf_seq_str and convert back to list
for i in range(1,50):
	buff_str = "%s" %(conf_seq_str[(8*(i-1)):(8*i)])
	conf_seq_reverse.append(buff_str)
conf_seq_reverse.reverse()


# create C header file and SystemVerilog AXI transactions
# that program the overlay for the desired functionallity
sv_conf_seq = ""
conf_header = "uint32_t conf_seq = { \n\n "
buff_str = ""


for i in range(0,49):
	#                                          conf_address  burst_length                                       conf_word
	sv_conf_seq += "bs.WRITE_BURST(12\'h000, 32\'h7600_0200, 8\'h00, 3\'b010, 2\'b01, 2\'b00, 4\'h0, 3\'b000, 32\'h%s, 5, bs_response); \n" %(conf_seq_reverse[i][:4]+ '_' + conf_seq_reverse[i][4:])
	if i != 48:
		conf_header += "0x" + str(conf_seq_reverse[i]) + ", "
	else:
		conf_header += "0x" + str(conf_seq_reverse[i])
	if i%10 == 9:
		conf_header += "\n"
conf_header += "\n}"

# create *.h file
c_header = open("conf_header.h", "w")
c_header.write(conf_header)
c_header.close()

# create *.sv file
sv_conf = open("axi_conf_transaction.sv", "w")
sv_conf.write(sv_conf_seq)
sv_conf.close()

