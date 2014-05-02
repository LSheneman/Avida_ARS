#Makefile
#Recreates all data files for anaylzes 
#CSE845 project group B, Spring 2014, MSU
#Leigh Sheneman, S. Kevin McCormick, Zach Laubach

all: prelimn, control_world, small_world, large_world

prelim:
	mkdir data

control_world: prelim
	./avida -c src/avida-evo.cfg -s 1 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/medium_R01 -set WORLD_X 20 -set WORLD_Y 2000
	./avida -c src/avida-evo.cfg -s 453 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/medium_R02 -set WORLD_X 20 -set WORLD_Y 2000
	./avida -c src/avida-evo.cfg -s 171689 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/medium_R03 -set WORLD_X 20 -set WORLD_Y 2000
	./avida -c src/avida-evo.cfg -s 489 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/medium_R04 -set WORLD_X 20 -set WORLD_Y 2000
	./avida -c src/avida-evo.cfg -s 34224 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/medium_R05 -set WORLD_X 20 -set WORLD_Y 2000
	./avida -c src/avida-evo.cfg -s 907 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/medium_R06 -set WORLD_X 20 -set WORLD_Y 2000
	./avida -c src/avida-evo.cfg -s 8548 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/medium_R07 -set WORLD_X 20 -set WORLD_Y 2000
	./avida -c src/avida-evo.cfg -s 806505 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/medium_R08 -set WORLD_X 20 -set WORLD_Y 2000
	./avida -c src/avida-evo.cfg -s 1999 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/medium_R09 -set WORLD_X 20 -set WORLD_Y 2000
	./avida -c src/avida-evo.cfg -s 2003 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/medium_R10 -set WORLD_X 20 -set WORLD_Y 2000
	./avida -c src/avida-evo.cfg -s 7890 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/medium_R11 -set WORLD_X 20 -set WORLD_Y 2000
	./avida -c src/avida-evo.cfg -s 12345 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/medium_R12 -set WORLD_X 20 -set WORLD_Y 2000
	./avida -c src/avida-evo.cfg -s 3 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/medium_R13 -set WORLD_X 20 -set WORLD_Y 2000
	./avida -c src/avida-evo.cfg -s 6 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/medium_R14 -set WORLD_X 20 -set WORLD_Y 2000
	./avida -c src/avida-evo.cfg -s 13 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/medium_R15 -set WORLD_X 20 -set WORLD_Y 2000
	./avida -c src/avida-evo.cfg -s 27 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/medium_R16 -set WORLD_X 20 -set WORLD_Y 2000
	./avida -c src/avida-evo.cfg -s 55 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/medium_R17 -set WORLD_X 20 -set WORLD_Y 2000
	./avida -c src/avida-evo.cfg -s 111 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/medium_R18 -set WORLD_X 20 -set WORLD_Y 2000
	./avida -c src/avida-evo.cfg -s 125 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/medium_R19 -set WORLD_X 20 -set WORLD_Y 2000
	./avida -c src/avida-evo.cfg -s 144 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/medium_R20 -set WORLD_X 20 -set WORLD_Y 2000
	./avida -c src/avida-evo.cfg -s 1441 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/medium_R21 -set WORLD_X 20 -set WORLD_Y 2000
	./avida -c src/avida-evo.cfg -s 14141 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/medium_R22 -set WORLD_X 20 -set WORLD_Y 2000
	./avida -c src/avida-evo.cfg -s 23241 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/medium_R23 -set WORLD_X 20 -set WORLD_Y 2000
	./avida -c src/avida-evo.cfg -s 24135 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/medium_R24 -set WORLD_X 20 -set WORLD_Y 2000
	./avida -c src/avida-evo.cfg -s 54175 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/medium_R25 -set WORLD_X 20 -set WORLD_Y 2000
	./avida -c src/avida-evo.cfg -s 83729 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/medium_R26 -set WORLD_X 20 -set WORLD_Y 2000
	./avida -c src/avida-evo.cfg -s 8379 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/medium_R27 -set WORLD_X 20 -set WORLD_Y 2000
	./avida -c src/avida-evo.cfg -s 9179 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/medium_R28 -set WORLD_X 20 -set WORLD_Y 2000
	./avida -c src/avida-evo.cfg -s 11179 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/medium_R29 -set WORLD_X 20 -set WORLD_Y 2000
	./avida -c src/avida-evo.cfg -s 721613 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/medium_R30 -set WORLD_X 20 -set WORLD_Y 2000

small_world: prelim
	./avida -c src/avida-evo.cfg -s 1 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/small_R01 -set WORLD_X 10 -set WORLD_Y 1000
	./avida -c src/avida-evo.cfg -s 453 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/small_R02 -set WORLD_X 10 -set WORLD_Y 1000
	./avida -c src/avida-evo.cfg -s 171689 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/small_R03 -set WORLD_X 10 -set WORLD_Y 1000
	./avida -c src/avida-evo.cfg -s 489 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/small_R04 -set WORLD_X 10 -set WORLD_Y 1000
	./avida -c src/avida-evo.cfg -s 34224 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/small_R05 -set WORLD_X 10 -set WORLD_Y 1000
	./avida -c src/avida-evo.cfg -s 907 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/small_R06 -set WORLD_X 10 -set WORLD_Y 1000
	./avida -c src/avida-evo.cfg -s 8548 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/small_R07 -set WORLD_X 10 -set WORLD_Y 1000
	./avida -c src/avida-evo.cfg -s 806505 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/small_R08 -set WORLD_X 10 -set WORLD_Y 1000
	./avida -c src/avida-evo.cfg -s 1999 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/small_R09 -set WORLD_X 10 -set WORLD_Y 1000
	./avida -c src/avida-evo.cfg -s 2003 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/small_R10 -set WORLD_X 10 -set WORLD_Y 1000
	./avida -c src/avida-evo.cfg -s 7890 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/small_R11 -set WORLD_X 10 -set WORLD_Y 1000
	./avida -c src/avida-evo.cfg -s 12345 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/small_R12 -set WORLD_X 10 -set WORLD_Y 1000
	./avida -c src/avida-evo.cfg -s 3 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/small_R13 -set WORLD_X 10 -set WORLD_Y 1000
	./avida -c src/avida-evo.cfg -s 6 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/small_R14 -set WORLD_X 10 -set WORLD_Y 1000
	./avida -c src/avida-evo.cfg -s 13 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/small_R15 -set WORLD_X 10 -set WORLD_Y 1000
	./avida -c src/avida-evo.cfg -s 27 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/small_R16 -set WORLD_X 10 -set WORLD_Y 1000
	./avida -c src/avida-evo.cfg -s 55 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/small_R17 -set WORLD_X 10 -set WORLD_Y 1000
	./avida -c src/avida-evo.cfg -s 111 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/small_R18 -set WORLD_X 10 -set WORLD_Y 1000
	./avida -c src/avida-evo.cfg -s 125 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/small_R19 -set WORLD_X 10 -set WORLD_Y 1000
	./avida -c src/avida-evo.cfg -s 144 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/small_R20 -set WORLD_X 10 -set WORLD_Y 1000
	./avida -c src/avida-evo.cfg -s 1441 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/small_R21 -set WORLD_X 10 -set WORLD_Y 1000
	./avida -c src/avida-evo.cfg -s 14141 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/small_R22 -set WORLD_X 10 -set WORLD_Y 1000
	./avida -c src/avida-evo.cfg -s 23241 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/small_R23 -set WORLD_X 10 -set WORLD_Y 1000
	./avida -c src/avida-evo.cfg -s 24135 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/small_R24 -set WORLD_X 10 -set WORLD_Y 1000
	./avida -c src/avida-evo.cfg -s 54175 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/small_R25 -set WORLD_X 10 -set WORLD_Y 1000
	./avida -c src/avida-evo.cfg -s 83729 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/small_R26 -set WORLD_X 10 -set WORLD_Y 1000
	./avida -c src/avida-evo.cfg -s 8379 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/small_R27 -set WORLD_X 10 -set WORLD_Y 1000
	./avida -c src/avida-evo.cfg -s 9179 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/small_R28 -set WORLD_X 10 -set WORLD_Y 1000
	./avida -c src/avida-evo.cfg -s 11179 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/small_R29 -set WORLD_X 10 -set WORLD_Y 1000
	./avida -c src/avida-evo.cfg -s 721613 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/small_R30 -set WORLD_X 10 -set WORLD_Y 1000

large_world: prelim
	./avida -c src/avida-evo.cfg -s 1 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/large_R01 -set WORLD_X 40 -set WORLD_Y 4000
	./avida -c src/avida-evo.cfg -s 453 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/large_R02 -set WORLD_X 40 -set WORLD_Y 4000
	./avida -c src/avida-evo.cfg -s 171689 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/large_R03 -set WORLD_X 40 -set WORLD_Y 4000
	./avida -c src/avida-evo.cfg -s 489 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/large_R04 -set WORLD_X 40 -set WORLD_Y 4000
	./avida -c src/avida-evo.cfg -s 34224 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/large_R05 -set WORLD_X 40 -set WORLD_Y 4000
	./avida -c src/avida-evo.cfg -s 907 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/large_R06 -set WORLD_X 40 -set WORLD_Y 4000
	./avida -c src/avida-evo.cfg -s 8548 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/large_R07 -set WORLD_X 40 -set WORLD_Y 4000
	./avida -c src/avida-evo.cfg -s 806505 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/large_R08 -set WORLD_X 40 -set WORLD_Y 4000
	./avida -c src/avida-evo.cfg -s 1999 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/large_R09 -set WORLD_X 40 -set WORLD_Y 4000
	./avida -c src/avida-evo.cfg -s 2003 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/large_R10 -set WORLD_X 40 -set WORLD_Y 4000
	./avida -c src/avida-evo.cfg -s 7890 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/large_R11 -set WORLD_X 40 -set WORLD_Y 4000
	./avida -c src/avida-evo.cfg -s 12345 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/large_R12 -set WORLD_X 40 -set WORLD_Y 4000
	./avida -c src/avida-evo.cfg -s 3 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/large_R13 -set WORLD_X 40 -set WORLD_Y 4000
	./avida -c src/avida-evo.cfg -s 6 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/large_R14 -set WORLD_X 40 -set WORLD_Y 4000
	./avida -c src/avida-evo.cfg -s 13 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/large_R15 -set WORLD_X 40 -set WORLD_Y 4000
	./avida -c src/avida-evo.cfg -s 27 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/large_R16 -set WORLD_X 40 -set WORLD_Y 4000
	./avida -c src/avida-evo.cfg -s 55 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/large_R17 -set WORLD_X 40 -set WORLD_Y 4000
	./avida -c src/avida-evo.cfg -s 111 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/large_R18 -set WORLD_X 40 -set WORLD_Y 4000
	./avida -c src/avida-evo.cfg -s 125 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/large_R19 -set WORLD_X 40 -set WORLD_Y 4000
	./avida -c src/avida-evo.cfg -s 144 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/large_R20 -set WORLD_X 40 -set WORLD_Y 4000
	./avida -c src/avida-evo.cfg -s 1441 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/large_R21 -set WORLD_X 40 -set WORLD_Y 4000
	./avida -c src/avida-evo.cfg -s 14141 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/large_R22 -set WORLD_X 40 -set WORLD_Y 4000
	./avida -c src/avida-evo.cfg -s 23241 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/large_R23 -set WORLD_X 40 -set WORLD_Y 4000
	./avida -c src/avida-evo.cfg -s 24135 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/large_R24 -set WORLD_X 40 -set WORLD_Y 4000
	./avida -c src/avida-evo.cfg -s 54175 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/large_R25 -set WORLD_X 40 -set WORLD_Y 4000
	./avida -c src/avida-evo.cfg -s 83729 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/large_R26 -set WORLD_X 40 -set WORLD_Y 4000
	./avida -c src/avida-evo.cfg -s 8379 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/large_R27 -set WORLD_X 40 -set WORLD_Y 4000
	./avida -c src/avida-evo.cfg -s 9179 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/large_R28 -set WORLD_X 40 -set WORLD_Y 4000
	./avida -c src/avida-evo.cfg -s 11179 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/large_R29 -set WORLD_X 40 -set WORLD_Y 4000
	./avida -c src/avida-evo.cfg -s 721613 -set EVENT_FILE src/evo-events.cfg -set DATA_DIR data/large_R30 -set WORLD_X 40 -set WORLD_Y 4000
