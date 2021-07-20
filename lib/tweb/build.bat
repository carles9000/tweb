@echo off
@cls
@set path=c:\xampp\htdocs\master\harbour
@set include=c:\xampp\htdocs\master\harbour\include

del ..\tweb\tweb.hrb


@echo ===========================================
@echo Building TWeb ( GUI Bootstrap for Harbour )
@echo ===========================================

harbour tweb.prg /n /w /gh

@echo =================
@echo Copia a modpack !
@echo =================
copy tweb.ch  c:\xampp\htdocs\master\modpack.dist\lib\tweb\tweb.ch
copy tweb.css c:\xampp\htdocs\master\modpack.dist\lib\tweb\tweb.css
copy tweb.js  c:\xampp\htdocs\master\modpack.dist\lib\tweb\tweb.js
copy tweb.hrb c:\xampp\htdocs\master\modpack.dist\lib\tweb\tweb.hrb


pause
