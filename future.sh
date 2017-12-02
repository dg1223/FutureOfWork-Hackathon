echo -e "\nPart 1: Things you prefer to do\n"
echo -e "In this section, we will ask you five questions about your work-life preferences. You will answer on a scale of 1 to 10. You will get instructions on how the scale works for a question.\n"
echo -e "Let's begin!!!\n\n"

q1=0
q2=0
q3=0
q4=0
q5=0

# travelling, routine, fast-paced, physically demanding, tight deadlines
touch joblist.txt

while true; do
    echo -e "Q1. How much do you like to travel? (1 means you detest travelling and 10 means love it the most):  "
    read userinput
	if [ ${userinput} -gt 5 ]
		then
		q1=1
		awk -F [,] '/travelling/{ print $2 }' dataset.csv >> joblist.txt
	fi
	
	echo -e "\n\nQ2. What is your preferred type of work? (1 means you like surprises and challenges and 10 means you love a routine (or repetitive) work flow):  \n"
    read userinput
	if [ ${userinput} -gt 5 ]
		then
		q2=1
		awk -F [,] '/routine/{ print $2 }' dataset.csv >> joblist.txt
	fi
	
	echo -e "\n\nQ3. What type of work environment do you prefer? (1 means you like a fast-paced environment and 10 means you like a quiet environment): \n "
    read userinput
	if [ ${userinput} -gt 5 ]
		then
		q3=1
		awk -F [,] '/fast-paced/{ print $2 }' dataset.csv >> joblist.txt
	fi
	
	echo -e "\n\nQ4. Do you prefer physical or non-physical work? (1 means you like heavy lifting and running around and 10 means you like to sit down as much as possible):  \n"
    read userinput
	if [ ${userinput} -gt 5 ]
		then
		q4=1
		awk -F [,] '/physically demanding/{ print $2 }' dataset.csv >> joblist.txt
	fi
	
	echo -e "\n\nQ5. How much do deadlines motivate or accelerate your work flow? (1 means you love to work under deadlines and 10 means you cannot perform under deadlines):  \n"
    read userinput
	if [ ${userinput} -gt 5 ]
		then
		q5=1
		awk -F [,] '/tight deadlines/{ print $2 }' dataset.csv >> joblist.txt
	fi
	break
done

echo -e "\n\n\nYour preferences/non-preferences:\n\n"

case $q1 in
	"0" )
		echo -e "1. Travelling: You do not prefer travelling."
		;;
	"1" )
	 	echo -e "1. Travelling: You prefer travelling."
		;;
esac

case $q2 in
	"0" )
		echo  "2. Type of work: You prefer variation and changes."
		;;
	"1" )
		echo  "2. Type of work: You prefer routine/repetitive work."
		;;
esac

case $q3 in
	"0" )
		echo -e "3. Work environment: You prefer fast-paced environment."
		;;
	"1" )
		echo -e "3. Work environment: You prefer a quiet environment."
		;;
esac

case $q4 in
	"0" )
		echo -e "4. Physical/non-physical: You prefer physical work."
		;;
	"1" )
		echo -e "4. Physical/non-physical: You prefer non-physical work."
		;;
esac

case $q5 in
	"0" )
		echo -e "5. Deadlines: You feel motivated while working under deadlines."
		;;
	"1" )
		echo -e "5. Deadlines: You feel drained out while working under deadlines."
		;;
esac


echo -e "\nPart 2: Things you are good at\n"
echo -e "In this section, we will ask you five questions about your work environment preferences. You will answer on a scale of 1 to 10. You will get instructions on how the scale works for a question.\n"
echo -e "Let's begin!!!\n\n"

q6=0
q7=0
q8=0
q9=0
q10=0

# attention to detail, problem solving, collaboration, client service, project management

while true; do
    echo -e "Q1. How much attention to detail do you have? (1 means very poor and 10 means very strong):  \n"
    read userinput
	if [ ${userinput} -gt 5 ]
		then
		q6=1
		awk -F [,] '/attention to detail/{ print $2 }' dataset.csv >> joblist.txt
	fi
	
	echo -e "\n\nQ2. How confident are you at problem solving? (1 means not confident at all and 10 means extremely confident):  \n"
    read userinput
	if [ ${userinput} -gt 5 ]
		then
		q7=1
		awk -F [,] '/problem solving/{ print $2 }' dataset.csv >> joblist.txt
	fi
	
	echo -e "\n\nQ3. How is your collaborative skill? (1 means you only want to work independently and 10 means only like to work in a team):  \n"
    read userinput
	if [ ${userinput} -gt 5 ]
		then
		q8=1
		awk -F [,] '/collaboration/{ print $2 }' dataset.csv >> joblist.txt
	fi
	
	echo -e "\n\nQ4. How much client service experience do you have? (1 means you no experience at all and 10 means you are an expert):  \n"
    read userinput
	if [ ${userinput} -gt 5 ]
		then
		q9=1
		awk -F [,] '/client service/{ print $2 }' dataset.csv >> joblist.txt
	fi
	
	echo -e "\n\nQ5. How is your project management skill? (1 means you do not have any experience and 10 means you are a seasoned professional at it):  \n"
    read userinput
	if [ ${userinput} -gt 5 ]
		then
		q10=1
		awk -F [,] '/project management/{ print $2 }' dataset.csv >> joblist.txt
	fi
	break
done

# awk -F [,] -v var="$skill" '$0~var { print "\n\n(" $1 ")" "\t" $2 "\n\n" $4}' dataset.csv | sed -e 's/; /\n/g'
echo -e "\n\n__________________________________________________\n\n"

#touch joblist_clean.txt
touch joblist_unique.txt
touch joblist_unique_prob.txt
touch joblist_unique_prob_sorted.txt
touch jobtitle_sorted.txt

#tr -d ',' < joblist.txt >> joblist_clean.txt
sort -u joblist.txt >> joblist_unique.txt

while read J
	do
		awk -F [,] -v var="$J" '$0~var { print $2 "," $3 }' dataset.csv >> joblist_unique_prob.txt
	done < joblist_unique.txt

sort -n -t',' -k2 joblist_unique_prob.txt >> joblist_unique_prob_sorted.txt
sed 's/,.*//g' joblist_unique_prob_sorted.txt >> jobtitle_sorted.txt
head -5 jobtitle_sorted.txt > top5.txt

echo -e "You should look for the following jobs and/or skillsets:\n\n"

while read K
	do
		awk -F [,] -v var="$K" '$0~var { print "\n\n(" $1 ")" "\t" $2 "\n\n" $4 "\n"}' dataset.csv | sed -e 's/; /\n/g'
	done < top5.txt


rm job*.*
