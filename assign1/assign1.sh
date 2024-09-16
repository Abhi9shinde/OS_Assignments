clear

c=0

while test $c != 7
do

	echo "1-> Create  2-> View 3-> Insert 4-> Delete 5-> Modify 6->Search 7-> Exit"

	read c

	case "$c" in

	#Create new file or access already created file
	"1")
	echo "Enter File Name"
	read db
	touch $db
	;;

	#View Address_Book
	"2")
	if [ -z "$db" ]; then
        echo "No file selected. Please create or access a file first."
    else
        echo -e "ID \tName \tAge \tPhoneNo. \tEmail"
        cat "$db"
    fi
    ;;

	#Insert Record
	"3")
	echo "Enter ID:"
	read id
	pa_id="^[0-9]{2}$"
	while [[ ! "$id" =~ $pa_id ]]
	do
		echo "Enter valid 2 digit id"
		read id
	done

	echo "Enter Name"
	read name
	pa_name="^[A-Za-z]+$"
	while [[ ! "$name" =~ $pa_name ]]
	do	
		echo "Please Enter a valid name"
		read name
	done

	echo "Enter Age"
	read age

	echo "Enter Phone Number"
	read number
	pa_num="^[0-9]{10}$"
	while [[ ! $number =~ $pa_num ]]
	do
		echo "Enter valid phone number"
		read number
	done

	echo "enter email:"
	read email
	patem="^[a-z0-9._%-+]+@[a-z]+\.[a-z]{2,4}$"
	while [[ ! $email =~ $patem ]]
	do
	    echo "please enter valid email address"
	    read email
	done
	echo -e "$id \t$name\t$age\t$number\t$email" >> "$db"
	echo "Record Added"
	;;

	#delete a record
	"4")
	echo "Enter ID of the record you want to delete"
	read id
	sed -i '/'$id'/d' $db
	;;
	
	#Modify record
	"5")

	echo "1.Name  2.ID  3.Email  4.Phone Number"
	read a
	case "$a" in 
	"1")
	echo "Enter name you want to change"
	read oldname
	echo "Enter new name"
	read newname
	pa_name="^[A-Za-z]+$"
	while [[ ! "$newname" =~ $pa_name ]]
	do	
		echo "Please Enter a valid name"
		read newname
	done
	sed -i 's/'$oldname/$newname/ $db
	;;
	"2")
	echo "Enter ID you want to change"
	read oldid
	echo "Enter new ID"
	read newid
	pa_id="^[0-9]{2}$"
	while [[ ! "$newid" =~ $pa_id ]]
	do
		echo "Enter valid 2 digit id"
		read newid
	done
	sed -i 's/'$oldid/$newid/ $db
	;;
	"3")
	echo "Enter Email you want to change"
	read oldemail
	echo "Enter new Email"
	read newemail
	patem="^[a-z0-9._%-+]+@[a-z]+\.[a-z]{2,4}$"
	while [[ ! $newemail =~ $patem ]]
	do
	    echo "please enter valid email address"
	    read newemail
	done
	sed -i 's/'$oldemail/$newemail/ $db
	;;
	"4")
	echo "Enter Phone number you want to delete"
	read oldnum
	echo "Enter new Phone number"
	read newnum
	pa_num="^[0-9]{10}$"
	while [[ ! $newnum =~ $pa_num ]]
	do
		echo "Enter valid phone number"
		read newnum
	done
	sed -i 's/'$oldnum/$newnum/ $db
	esac
	;;

	#Search any record by name
	"6")
	echo "Enter Name you want to search"
	read name
	grep -i $name $db
	;;

	"7")
	echo "Exit"
	exit
	;;

	esac


done
exit