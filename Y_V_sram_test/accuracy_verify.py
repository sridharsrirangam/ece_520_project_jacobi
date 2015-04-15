import os, re, math

fstd  = open('vstd_data1.txt',  'r')
ftest = open('testout_data1.txt', 'r')

max_diff = 0.00
max_pct  = 0.00
#while 1:

#a[8]={}

while 1:
#for x in range(0,250):
    std_line  = fstd.readline()
    test_line = ftest.readline()
    if not std_line: break
    if not test_line: break
    std_vec  = re.findall(r"(\w\w\w\w\w\w)", std_line)
    test_vec = re.findall(r"(\w\w\w\w\w\w)", test_line)
#    print std_vec
#    print test_vec
#    print int(std_vec[1],16)
    std_val = [0,0,0,0,0,0,0,0]
    test_val = [0,0,0,0,0,0,0,0]
    for i in range(0,8):
	std_dec  = int(std_vec[i], 16)
	test_dec = int(test_vec[i], 16)
	sign  = int(std_dec/pow(2,23))
	std_dec  = std_dec - sign*pow(2,23)
	power = int(std_dec/pow(2,17))-48
	std_dec  = std_dec - (power+48)*pow(2,17)
	frac  = std_dec
#	print "sign, power, frac = ", sign, power, frac
	std_val[i] = pow(-1,sign) * pow(2,power) * (1+float(frac)/pow(2,17))

	sign  = int(test_dec/pow(2,23))
	test_dec  = test_dec - sign*pow(2,23)
	power = int(test_dec/pow(2,17))-48
	test_dec  = test_dec - (power+48)*pow(2,17)
	frac  = test_dec
	test_val[i] = pow(-1,sign) * pow(2,power) * (1+float(frac)/pow(2,17))

#	print std_vec[i], test_vec[i]
    std_mag = [math.sqrt(pow(std_val[0],2)+pow(std_val[1],2)), math.sqrt(pow(std_val[2],2)+pow(std_val[3],2)), math.sqrt(pow(std_val[4],2)+pow(std_val[5],2)), math.sqrt(pow(std_val[6],2)+pow(std_val[7],2))]
    test_mag = [math.sqrt(pow(test_val[0],2)+pow(test_val[1],2)), math.sqrt(pow(test_val[2],2)+pow(test_val[3],2)), math.sqrt(pow(test_val[4],2)+pow(test_val[5],2)), math.sqrt(pow(test_val[6],2)+pow(test_val[7],2))]
    diff_mag = [abs(std_mag[0] - test_mag[0]), abs(std_mag[1] - test_mag[1]), abs(std_mag[2] - test_mag[2]), abs(std_mag[3] - test_mag[3])]
    diff_pct = [diff_mag[0]/std_mag[0], diff_mag[1]/std_mag[1], diff_mag[2]/std_mag[2], diff_mag[3]/std_mag[3]]
    max_diff = max(max_diff, max(diff_mag))
    max_pct  = max(max_pct, max(diff_pct))
#    print diff_mag
#    print diff_pct
#    print "max_diff = ", max_diff
#    print "max_pct = ", max_pct

#    if re.finditer(r'((\w)\1))', line):
#	fstd0r = re.findall(r'(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)', line)[0]
#	fstd0i = re.findall(r'(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)', line)[1]
#	fstd1r = re.findall(r'(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)', line)[2]
#	fstd1i = re.findall(r'(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)', line)[3]
#	fstd2r = re.findall(r'(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)', line)[4]
#	fstd2i = re.findall(r'(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)', line)[5]
#	fstd3r = re.findall(r'(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)', line)[6]
#	fstd3i = re.findall(r'(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)(([0-9A-Fa-f])\5+)', line)[7]
#    print fstd0r, fstd0i, fstd1r, fstd1i, fstd2r, fstd2i, fstd3r, fstd3i

fstd.close()
ftest.close()

print "max_diff = ", max_diff
print "max_pct(%) = ", max_pct*100
if max_diff <=0.005:
    print "Met!"
else:
    print "Violated!"






