#! /bin/bash
echo "------------------------------"
echo "User Name: 이수용"
echo "Student Number: 12173344"
echo "[ MENU ]"
echo "1. Get the data of the movie identified by a specific 'movie id' from 'u.item'"
echo "2. Get the data of action genre movies from 'u.item'"
echo "3. Get the average 'rating' of the movie identified by specific 'movie id' from 'u.data'"
echo "4. Delete the 'IMDB URL' from 'u.item'"
echo "5. Get the data about users from 'u.user'"
echo "6. Modify the format of 'release date' in 'u.item'"
echo "7. Get the data of movies rated by a specific 'user id' from 'u.data'"
echo "8. Get the average 'rating' of movies rated by users with 'age' between 20 and 29 and 'occupation' as 'programmer'"
echo "9. Exit"
echo "------------------------------"

n=0
while ((n >= 0))
do
	read -p "Enter your choice [ 1-9 ] " num
	echo -e
	case $num in
	
	# requirement 1
	1)
	read -p "Please enter 'movie id'(1~1682) : " movie_id
	echo -e
	awk -F\| -v id=$movie_id '$1==id {print $0}' u.item
	echo -e;;

	# requirement 2
	2)
	read -p "Do you want to get the data of 'action' genre movies from 'u.item'?(y/n) :" answer
	echo -e
	if [ "$answer" = "y" ]; 
	then
		awk -F\| '$7==1 { if(i < 10) {print $1, $2; i++}}' u.item
		echo -e
	fi;;

	# requirement 3
	3)
	read -p "Please enter the movie id (1~1682) :" movie_id
	echo -e
	awk -v id=$movie_id '$2==id {j+=$3; i++;} 
	END {printf("average rating of %d: %.5f\n", movie_id, j/i)}' u.data
	echo -e;;

	# requirement 4
	4)
	read -p "Do you want to delete the 'IMDB URL' from 'u.item'? (y/n) :" answer
	if [ "$answer" = "y" ]; 
	then
		awk -F\| '{print}' u.item | sed 's/\(http[^|]*\)|/|/g'| head -n 10
		echo -e
	fi;;

	# requirement 5
	5)
	read -p "Do you want to get the data about users from 'u.user'? (y/n) :" answer
	if [ "$answer" = "y" ];
	then
		awk -F\| '{printf("user %d is %d years old %s %s\n", $1, $2, $3, $4)}' u.user | sed -e 's/F/female/' -e 's/M/male/'| head -n 10	
		echo -e
	fi;;

	# requirement 6
	6)
	read -p "Do you want to Modify the format of 'release data' in 'u.item'?(y/n) :" answer
	if [ "$answer" = "y" ]; 
	then
		echo -e
		awk -F\| '1673<=NR && NR<=1682 {print}' u.item | sed -e 's/(Jan)/01/g; s/(Feb)/02/g; s/(Mar)/03/g;s/(Apr)/04/g; s/(May)/05/g; s/(Jun)/06/g; s/(Jul)/07/g; s/(Aug)/08/g; s/(Sep)/09/g; s/(Oct)/10/g; s/(Nov)/11/g; s/(Dec)/12/g;'
		echo -e
	fi;;

	# requirement 7
	7)
	read -p "Please enter the 'user id' (1~943) :" user_id
	echo -e
	;;
			
	# requirement 8
	8) 
	read -p "Do you want to get the average 'rating' of movies rated by users with 'age' between 20 and 29 and 'occupations' as 'programmer? (y/n) :" answer 
        echo -e 	
	;; 

	# requirement 9
	9)
	echo "Bye!"
	n=-1;;

	*)
	echo "Wrong answer!"
	echo -e
	;;
	esac 
done 


