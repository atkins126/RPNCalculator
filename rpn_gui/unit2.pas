unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, StrUtils, Process, UnitStack, UnitEntity, UnitFunctions;

const
	PI = 3.1415926535897932384626433832795;
	EU = 2.7182818284590452353602874713526;
	FI = 1.6180339887498948482045868343656;


function commentcut(input : String) : String;
procedure evaluate(i : String; var pocz : StackDB; var Steps : Integer; var sets : TSettings; var vardb : VariableDB);
function read_sourcefile(filename : String; var pocz : StackDB; var sets : TSettings; var vardb : VariableDB) : String;
function parseRPN(input : string; var pocz : StackDB; var sets : TSettings; var vardb : VariableDB) : String;
function calc_parseRPN(input : string; var sets : TSettings) : String;

implementation
uses Unit5;

var
        Steps : Integer;


// EVALUATION

procedure evaluate(i : String; var pocz : StackDB; var Steps : Integer; var sets : TSettings; var vardb : VariableDB);
var
    Im     : Extended;
    Code   : Longint;
    StrEcx : String;
begin
    Steps := 1;

    StrEcx := i;
    // stack_push(pocz, buildString(StrEcx));
    if not (sets.CaseSensitive) then i := LowerCase(i);
    Val (i,Im,Code);
    If Code<>0 then
    begin
        if not lib_directives(i, pocz, Steps, sets, vardb) then
        if not lib_constants(i, pocz, Steps, sets, vardb) then
        if not lib_logics(i, pocz, Steps, sets, vardb) then
        if not lib_variables(i, pocz, Steps, sets, vardb) then
        if not lib_ultravanilla(i, pocz, Steps, sets, vardb) then
        stack_push(pocz, buildString(StrEcx));
    end else begin
        stack_push(pocz, buildNumber(Im));
    end;
end;

function commentcut(input : String) : String;
var 
  pom         : String;
  togglequote : Boolean;
  i           : Integer;
begin
  pom := '';
  togglequote := false;
  for i := 0 to Length(input) do begin
  	if (input[i] = '"') then togglequote := not (togglequote);
    if (not ((input[i] = '/') and (input[i+1] = '/'))) or (togglequote) then begin
      pom := concat(pom, input[i]);
    end else begin
      if not (togglequote) then break;
    end;
  end;
  commentcut := pom;
end;

function read_sourcefile(filename : String; var pocz : StackDB; var sets : TSettings; var vardb : VariableDB) : String;
var
  fun, S : String;
  fp     : Text;
begin
  fun := '';
  assignfile(fp, filename);
  reset(fp);
  while not eof(fp) do
  begin
    readln(fp, S);
    if (S <> '') then S := commentcut(S);
    fun := fun + ' ' + S;
  end;
  closefile(fp);
  S := parseRPN(fun, pocz, sets, vardb);
  read_sourcefile := S;
end;

function parseRPN(input : string; var pocz : StackDB; var sets : TSettings; var vardb : VariableDB) : String;
var
        L      : TStrings;
        i      : String;
        index  : LongInt;
        z      : String;
        step   : Integer;
        cursor : LongInt;
        nestlv : ShortInt;
        nesttx : String;
        cond   : ShortInt;
        permit : Boolean;
begin
	L := TStringlist.Create;
	L.Delimiter := ' ';
	L.QuoteChar := '"';
	L.StrictDelimiter := false;
	L.DelimitedText := input;

  	Steps := 1;
  	cond := -1;
  	permit := True;
  	index := 0;
  	while index < L.Count do
	begin
		if L[index] = '?' then begin
			cond := trunc(stack_pop(pocz).Num);
		end else if (L[index] = 'if') then begin
			if cond = 0 then permit := True
			else permit := False;
		end else if L[index] = 'else' then begin
			if cond = 0 then permit := False
			else permit := True;
		end else begin
			if L[index] = '{' then begin
	    		nestlv := 1;
	    		nesttx := '';
	    		cursor := index + 1;
	    		while (nestlv > 0) and (cursor < L.Count) do begin
	    			if (L[cursor] = '{') then Inc(nestlv);
	    			if (L[cursor] = '}') then Dec(nestlv);
	    			if (nestlv > 0) and (L[cursor] <> DelSpace(L[cursor])) then nesttx := nesttx + ' ' + ANSIQuotedStr(L[cursor], '"')
	    			else if (nestlv > 0) then nesttx := nesttx + ' ' + L[cursor];
	    			Inc(cursor);
	    		end;
	    		if (permit) then
	    			if Steps = -1 then begin
	    				repeat
	    				  parseRPN(nesttx, pocz, sets, vardb); 
	    				until EOF;
	    				stack_pop(pocz);
	    			end else for step := 1 to Steps do parseRPN(nesttx, pocz, sets, vardb);
	    		permit := True;
	    		index := cursor - 1;
	    	end else begin
	    		if (permit) then
	    			if Steps = -1 then begin
	    				repeat
	    					evaluate(L[index], pocz, Steps, sets, vardb);
	    				until EOF;
	    				stack_pop(pocz);
	    			end else for step := 1 to Steps do evaluate(L[index], pocz, Steps, sets, vardb);
	    		permit := True; 
	    	end;
	    end;
    	Inc(index);
  	end;
  z := '';
  L.Free;

  parseRPN := z;
end;

function calc_parseRPN(input : string; var sets : TSettings) : String;
var
  stack  : StackDB;
  res    : String;
  vardb  : VariableDB;
begin
  stack := stack_null();
  vardb := createVariables();
  res := parseRPN(input, stack, sets, vardb);
  res := stack_show(stack, sets.Mask);
  calc_parseRPN := res;
end;


end.
