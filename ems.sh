#!/bin/bash
EDITOR=vim
PASSWD=/etc/passwd
RED='\033[0;41;30m'
STD='\033[0;0;39m'
 
pause(){
	read -p "Press [Enter] key to continue..."
}

readEmp(){
        echo "readEmp() called"
        read -p "Employee Number: " emp_no
        commands="
        use employees;
        SELECT * FROM employees WHERE emp_no='${emp_no}';"
        echo "${commands}" | /usr/bin/mysql -u secretary2 -p
        pause
}
 
readTable(){
	show_table_menu
	local table_choice
	read -p "Enter choice [ 1 - 7] " table_choice
	case $table_choice in
                1) table="employees" ;;
                2) table="salaries" ;;
                3) table="titles" ;;
                4) table="departments" ;;
                5) table="dept_manager" ;;
                6) table="dept_emp" ;;
                7) exit 0 ;;
                *) echo -e "${RED}Error. Please select from [ 1 - 7 ]${STD}" && sleep 2
	esac	
	commands="
	use employees;
	SELECT * FROM ${table};"
	echo "${commands}" | /usr/bin/mysql -u secretary2 -p
        pause
}
 
createEmp(){
        echo "createEmp() called"
	read -p "First Name: " first_name
	read -p "Last Name: " last_name
	read -p "Birthday: " birth_date
	read -p "Gender: " gender
	read -p "Department: " dept_no
	read -p "Salary: " salary
	commands="
	use employees;
	call newEmp('${first_name}', '${last_name}', '${birth_date}', '${gender}', '${dept_no}', '${salary}');"

	echo "${commands}" | /usr/bin/mysql -u secretary2 -p
        pause
}
 
updateEmp(){
        echo "updateEmp() called"
	read -p "Employee Number: " emp_no
	read -p "First Name: " first_name
	read -p "Last Name: " last_name
	read -p "Birthday: " birth_date
	read -p "Gender: " gender
	read -p "Department: " dept_no
	read -p "Salary: " salary
	commands="
	use employees;
	call updateEmpPersonalInfo('${emp_no}', '${first_name}', '${last_name}', '${birth_date}', '${gender}');"

	echo "${commands}" | /usr/bin/mysql -u secretary2 -p
	pause
}

deleteEmp(){
        echo "deleteEmp() called"
	read -p "Employee Number: " emp_no
	commands="
	use employees;
	DELETE FROM employees WHERE emp_no='${emp_no}';"
	echo "${commands}" | /usr/bin/mysql -u secretary2 -p
	pause
}

show_menus() {
        clear
        echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~"    
        echo " Employee Management System"
        echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        echo "1. Read An Employee's Full Record"
        echo "2. Select and Read a Table"
        echo "3. Insert a New Employee"
        echo "4. Update an Employee Record"
        echo "5. Delete an Employee Record"
        echo "6. Exit"
}
show_table_menu() {
        clear
        echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        echo " Please select a Table to View "
        echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        echo "1. Employees"
        echo "2. Salaries"
        echo "3. Titles"
        echo "4. Departments"
	echo "5. Department Managers"
        echo "6. Department Employees"
        echo "7. Exit"
}
read_options(){
        local menu_choice
        read -p "Enter choose from [ 1 - 6 ] " menu_choice
        case $menu_choice in
                1) readEmp ;;
                2) readTable ;;
                3) createEmp ;;
                4) updateEmp ;;
                5) deleteEmp ;;
                6) exit 0;;
                *) echo -e "${RED}Error. Please choose from [ 1 - 6 ]${STD}" && sleep 2
        esac
}
 
trap '' SIGINT SIGQUIT SIGTSTP
 
while true
do
 
        show_menus
        read_options
done

