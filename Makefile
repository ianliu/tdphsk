TARGETS = renders/bot-center.stl \
	  renders/bot-rl.stl \
	  renders/mid-center.stl \
	  renders/mid-rl.stl \
	  renders/top-center.stl \
	  renders/top-rl.stl

all: $(TARGETS)

renders/%.stl: 3dkeeb.scad
	mkdir -p renders
	openscad -D'view="$*"' -o $@ $<

clean:
	-rm -f renders/*.stl
