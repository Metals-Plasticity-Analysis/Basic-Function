awk 'NR>49 {print}' *.ang >temp1.temp
awk 'NF>1 {print}' temp1.temp>temp2.temp
awk '{print $1*(180/3.14)" "$2*(180/3.14)" "$3*(180/3.14)}' temp2.temp >temp3.temp
awk '{print $0 OFS "1.0"}' temp3.temp>temp4.temp
awk 'BEGIN{print "B"} END{print NR}' temp4.temp |paste -sd " " >temp5.temp
cat temp5.temp temp4.temp > temp6.temp
awk 'BEGIN { print "Dummy Line no. 1" ; print "Dummy Line no. 2" ; print "Dummy Line no. 3" } { print $0 }' temp6.temp > vpsc_input.tex
rm -fv *.temp
