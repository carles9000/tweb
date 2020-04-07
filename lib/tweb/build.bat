@echo off
@cls
@set    path=c:\harbour\bin
@set include=c:\harbour\include

del tweb.hrb


@echo =======================================
@echo Building TWeb ( GUI Genesis Bootstrap )
@echo =======================================

harbour tweb.prg /n /w /gh

pause