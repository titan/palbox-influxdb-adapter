NAME = box-influxdb-adapter
BUILDDIR=/dev/shm/${NAME}
TARGET = $(BUILDDIR)/box_influxdb_adapter

CORESRC:=$(BUILDDIR)/src/box_influxdb_adapter.nim
BUILDSRC:=$(BUILDDIR)/box_influxdb_adapter.nimble

all: $(TARGET)

$(TARGET): $(CORESRC) $(BUILDSRC) $(PROTOSRC)
	cd $(BUILDDIR); nimble build; cd -

$(CORESRC): core.org | prebuild
	org-tangle $<

$(BUILDSRC): build.org | prebuild
	org-tangle $<

prebuild:
ifeq "$(wildcard $(BUILDDIR))" ""
	@mkdir -p $(BUILDDIR)/src
endif

clean:
	rm -rf $(BUILDDIR)

.PHONY: all clean prebuild
