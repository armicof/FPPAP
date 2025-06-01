@echo off
cd /d %~dp0
set PYTHON="D:\Python\python.exe"
%PYTHON% convertXLSXtoCSV.py
pause