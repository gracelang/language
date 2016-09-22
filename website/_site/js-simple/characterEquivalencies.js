/*
***  Provides Support for Charachter Equivilancies ***
     *This file contains the setupCharacterEquivalencies() function that is run in
      startup() when the editor first loads.
     *The function creates new command keys to support automatic conversion between
      != and ≠ for example. See the 'replacements' obj. for more info.
*/


function setupCharacterEquivalencies()
{
  var cursorMoved = false;  //Global varaible to be set when the cursor moves
                         //after a charachter replacement occurs

  //Possible replacements in the editor
  var replacements =
  {
       "!=":"≠",
       ">=":"≥",
       "<=":"≤",
       "->":"→",
       "[[":"⟦",
       "]]":"⟧"
 };

//Possible replacements for undoing the original replace
 var undoReplace =
 {
      "≠":"!=",
      "≥":">=",
      "≤":"<=",
      "→":"->",
      "⟦":"[[",
      "⟧":"]]"
 };

 //Symbols to add as commands
 var endSymbols = ['=','>','[',']'];

  //****** Add All Character Equivalancies ********//
  for(i =0; i<4; ++i)
  {
       var a = endSymbols[i];
       addCharEq(a);
  }

function addCharEq(a)
{
     editor.commands.addCommand({
        name: 'myCommand'+a,
        bindKey: {win: a,  mac: a},
        exec: function(editor) {
            //Insert '=' to support standard functionality
            editor.insert(a);

            //Set the cursor moved to false to allow backspace replacement
            cursorMoved = false;

            //Calculate the cursor position
            var cursor = editor.getCursorPosition();
            Range = require("ace/range").Range;

            //Check if replacement is possible
            if(cursor.column >= 2){

                  //Get the range and the text
                  var cursorLine = new Range(cursor.row, cursor.column-2, cursor.row, cursor.column);
                  var text = editor.session.getTextRange(cursorLine);
                  if(text in replacements)
                  {
                       //Insert the matching symbol
                       editor.session.replace(cursorLine, replacements[text]);

                       //Store text for undo
                       lastReplacement = text;
                  }
            }
        },
        readOnly: false // false if this command should not apply in readOnly mode
     });
}


//****** BACKSPACE Command Key ********//
  editor.commands.addCommand({
      name: 'BACK',
      bindKey: {win: 'backspace',  mac: 'backspace'},
      exec: function(editor) {
           var cursor = editor.getCursorPosition();
           Range = require("ace/range").Range;

           //Check if there is text here, then look for !=
           if(cursor.column >= 1){
                var cursorLine = new Range(cursor.row, cursor.column-1, cursor.row, cursor.column);
                var text = editor.session.getTextRange(cursorLine);
                if(text in undoReplace && !cursorMoved)
                {
                     //Replace text - return true to signal overriden functionality
                     editor.session.replace(cursorLine,undoReplace[text]);
                     return true;
                }
           }

          //Return false to signal regular backspace functionality
          return false;

      },
      readOnly: false // false if this command should not apply in readOnly mode
  });


  //****** Cursor Move Check ********//
  //Editor check to see if the cursor has moved
  //used to provide dynamic replacement functionality
  editor.getSession().selection.on('changeSelection', function(e)
  {
       cursorMoved = true;
       editor.setOption({"text-indent":"0.1px"});
  });

}
