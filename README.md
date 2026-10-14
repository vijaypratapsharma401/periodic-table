# Periodic Table

`element.sh` looks up an element by atomic number, symbol, or name in the
`periodic_table` PostgreSQL database.

```sh
./element.sh 1
./element.sh Ne
./element.sh Neon
```

The script connects as the `freecodecamp` PostgreSQL user. `periodic_table.sql`
contains a dump of the corrected database, and `atomic_mass.txt` is the mass
reference used for this project.

Run the lookup smoke tests with:

```sh
./test.sh
```
