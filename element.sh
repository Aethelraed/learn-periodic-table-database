#!/bin/bash
#Elementary, my dear Watson
PSQL="psql --username=freecodecamp --dbname=periodic_table -A -t -c "

QUERY(){
  Q_RETURN=$($PSQL "select atomic_number,name,symbol,type,atomic_mass,melting_point_celsius,boiling_point_celsius from elements join
properties using(atomic_number) join types using(type_id) where $Q_COND;")
  IFS="|"
  read ATOM_NUM ATOM_NAME ATOM_SYMBOL ATOM_TYPE ATOM_MASS MELT BOIL < <(echo "$Q_RETURN")
  if [[ -z $ATOM_NUM ]]
  then
  echo "I could not find that element in the database."
  else
  echo "The element with atomic number $ATOM_NUM is $ATOM_NAME ($ATOM_SYMBOL). It's a $ATOM_TYPE, with a mass of $ATOM_MASS amu. $ATOM_NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
  fi
}


CLASSIFY_INPUT(){
  if [[ $U_IN =~ ^[0-9]+$ ]]
    then 
      Q_COND="atomic_number=$U_IN"
    else
      Q_COND="name='$U_IN' or symbol='$U_IN'"
  fi
}

U_IN=$1
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
  else 
    CLASSIFY_INPUT
    QUERY
fi




