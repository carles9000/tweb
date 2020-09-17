//	{% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o, oWeb
	LOCAL aLang := {"ActionScript",;
	                 "AppleScript",; 
	                 "Asp",; 
	                 "BASIC",; 
	                 "C",; 
	                 "C++",; 
	                 "Clojure",; 
	                 "COBOL",; 
	                 "ColdFusion",; 
	                 "Erlang",; 
	                 "Fortran",; 
	                 "Groovy",; 
	                 "Haskell",; 
	                 "Harbour",; 
	                 "Java",; 
	                 "JavaScript",; 
	                 "Lisp",; 
	                 "Perl",; 
	                 "PHP",; 
	                 "Python",; 
	                 "Ruby",; 
	                 "Scala",; 
	                 "Scheme" }
	
	
	DEFINE WEB oWeb TITLE 'Test Autocomplete' INIT

    DEFINE FORM o

    INIT FORM o  		
       
		HTML o INLINE '<h3>Test Get Autocomplete - Array</h3></hr>'
		
        ROWGROUP o
        
            GET ID 'myid'  VALUE '' GRID 6 LABEL 'Source: Array' AUTOCOMPLETE aLang OF o
            
        END o
		
    END FORM o	
	
retu nil