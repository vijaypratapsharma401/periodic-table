#!/bin/bash

if [[ -z "$1" ]]; then
  echo "Please provide an element as an argument."
  exit 0
fi

PSQL=(psql --username=freecodecamp --dbname=periodic_table -t --no-align --field-separator='|')
ELEMENT_INPUT=$(printf '%s' "$1" | sed "s/'/''/g")
ELEMENT_DATA=$("${PSQL[@]}" -c "SELECT e.atomic_number, e.name, e.symbol, t.type, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius FROM elements e JOIN properties p USING (atomic_number) JOIN types t USING (type_id) WHERE e.atomic_number::text = '$ELEMENT_INPUT' OR e.symbol = '$ELEMENT_INPUT' OR e.name = '$ELEMENT_INPUT';")

if [[ -z "$ELEMENT_DATA" ]]; then
  echo "I could not find that element in the database."
  exit 0
fi

IFS='|' read -r ATOMIC_NUMBER NAME SYMBOL TYPE MASS MELTING_POINT BOILING_POINT <<< "$ELEMENT_DATA"
printf "The element with atomic number %s is %s (%s). It's a %s, with a mass of %s amu. %s has a melting point of %s celsius and a boiling point of %s celsius.\n" \
  "$ATOMIC_NUMBER" "$NAME" "$SYMBOL" "$TYPE" "$MASS" "$NAME" "$MELTING_POINT" "$BOILING_POINT"