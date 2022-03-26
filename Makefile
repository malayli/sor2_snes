ifeq ($(strip $(PVSNESLIB_HOME)),)
$(error "Please create an environment variable PVSNESLIB_HOME with path to its folder and restart application. (you can do it on windows with <setx PVSNESLIB_HOME "/c/snesdev">)")
endif

AUDIOFILES := music.it
export SOUNDBANK := soundbank

include ${PVSNESLIB_HOME}/devkitsnes/snes_rules

.PHONY: logo leonardo bitmaps all

#---------------------------------------------------------------------------------
# ROMNAME is used in snes_rules file
export ROMNAME := snesdemo

SMCONVFLAGS	:= -s -o $(SOUNDBANK) -v -b 5
musics: $(SOUNDBANK).obj
 
#---------------------------------------------------------------------------------
all	: musics bitmaps $(ROMNAME).sfc

clean: cleanBuildRes cleanRom cleanGfx cleanAudio

blaze.pic: blaze.bmp
	@echo convert bitmap ... $(notdir $@)
	$(GFXCONV) -gs64 -pc16 -po16 -pe2 -n $<

galsia.pic: galsia.bmp
	@echo convert bitmap ... $(notdir $@)
	$(GFXCONV) -gs64 -pc16 -po16 -pe3 -n $<

signal.pic: signal.bmp
	@echo convert bitmap ... $(notdir $@)
	$(GFXCONV) -gs64 -pc16 -po16 -pe4 -n $<

frames.pic: frames.bmp
	@echo convert bitmap ... $(notdir $@)
	$(GFXCONV) -gs32 -pc16 -po16 -pe0 -n $<

caixa.pic: caixa.bmp
	@echo convert bitmap ... $(notdir $@)
	$(GFXCONV) -gs64 -pc16 -po16 -n $<

fase11BG1.pic: fase11BG1.bmp
	@echo convert bitmap ... $(notdir $@)
	$(GFXCONV) -pr -pc16 -n -gs8 -pe2 -fbmp -m -m32p $<

hud.pic: hud.bmp
	@echo convert bitmap ... $(notdir $@)
	$(GFXCONV) -pr -pc4 -n -gs8 -pe0 -fbmp -mp -mR!  $<

fase11BG2.pic: fase11BG2.bmp
	@echo convert bitmap ... $(notdir $<)
	$(GFXCONV) -pr -pc16 -n -gs8 -pe4 -fbmp -mp -m32p $<

soco.brr: soco.wav
	@echo convert wav file ... $(notdir $<)
	$(BRCONV) -e $< $@

dano.brr: dano.wav
	@echo convert wav file ... $(notdir $<)
	$(BRCONV) -e $< $@

bitmaps :  fase11BG1.pic soundbank.asm blaze.pic  fase11BG2.pic caixa.pic galsia.pic signal.pic hud.pic frames.pic soco.brr dano.brr
