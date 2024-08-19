#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"
if [[ -z $1  ]]
then
echo "Please provide an element as an argument."
else
 if [[ $1 =~ ^[0-9]+$ ]] 
 then
   WITH_ATOMIC=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$1")
   if [[ -z $WITH_ATOMIC ]]
   then
     echo "I could not find that element in the database."
   else
     echo $WITH_ATOMIC | while read TID b AT_NUM b SYM b NAME b AT_MASS b MP b BP b TYPE
   do
    echo "The element with atomic number $AT_NUM is $NAME ($SYM). It's a $TYPE, with a mass of $AT_MASS amu. $NAME has a melting point of $MP celsius and a boiling point of $BP celsius."
   done
   fi
 fi
 if [[ $1 =~ ^[A-Z][a-z]?$ ]]
 then
     WITH_SYMBOL=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol='$1'")
   if [[ -z $WITH_SYMBOL ]]
   then
     echo "I could not find that element in the database."
   else
     echo $WITH_SYMBOL | while read TID b AT_NUM b SYM b NAME b AT_MASS b MP b BP b TYPE
   do
    echo "The element with atomic number $AT_NUM is $NAME ($SYM). It's a $TYPE, with a mass of $AT_MASS amu. $NAME has a melting point of $MP celsius and a boiling point of $BP celsius."
   done
   fi
 fi
 if [[ $1 =~ [A-Z][a-z]{2,} ]]
 then
 WITH_SYMBOL=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE name='$1'")
   if [[ -z $WITH_SYMBOL ]]
   then
     echo "I could not find that element in the database."
   else
     echo $WITH_SYMBOL | while read TID b AT_NUM b SYM b NAME b AT_MASS b MP b BP b TYPE
   do
    echo "The element with atomic number $AT_NUM is $NAME ($SYM). It's a $TYPE, with a mass of $AT_MASS amu. $NAME has a melting point of $MP celsius and a boiling point of $BP celsius."
   done
   fi
 fi
fi


