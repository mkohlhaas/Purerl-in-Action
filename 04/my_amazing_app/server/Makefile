.PHONY: all clean repl

all:
	spago build
	rm -rf ../src/compiled_ps/
	mkdir -p ../src/compiled_ps/
	cp -r output/* ../src/compiled_ps/

repl:
	erl -pa ebin

clean:
	@rm -rf output/
	@rm -rf ebin/
	@rm -rf .spago/
	@rm -rf .purs-repl
