# DevelopmentEnvironment
My default development environment.

## Vimrc

### Brief Description

Upon startup the included vimrc will try to first load a preliminary vimrc defined by the user, then
run itself, and finally run a finalizing vimrc defined by the user.

### Preliminary vimrc

File Path: `~/.<hostname>.before.vimrc`

The purpose of this file is to define aspects of the development environment via global variables.
All global variables are optional such that if they are not defined, then a default value will be
assigned to them or a feature will be removed.

|Variable Name             | Purpose                                                                   | Behavior if not defined.                   |
|--------------------------|---------------------------------------------------------------------------|--------------------------------------------|
|`g:charLimit`             | Defines the character limit per line.                                     | Will use a default value of 80.            |
|`g:developmentUsername`   | Statically defines the user for this vimrc.                               | Will default to `$USER`.                   |
|`g:javaCompiler`          | Defines the compiler for java files.                                      | The compiler will not be set.              |
|`g:workspace`             | Defines the root directory of the workspace currently being developed in. | Will remain undefined. Tags will not work. |

### Finalizing vimrc

File Path: `~/.<hostname>.after.vimrc`

The purpose of this file is minimize modifications to the included vimrc by allowing the user to
change settings defined. Unless there is a bug all user-specific modifications should be made to
this file.

### Vim behavior modifications

The default leader is `,`.

#### Mappings

|Mode    |User Input | Description                                                        |
|--------|-----------|--------------------------------------------------------------------|
|Normal  |Ctrl-n     | Switches to the next buffer                                        |
|Normal  |Ctrl-p     | Switches to the previous buffer                                    |
|Normal  |Ctrl-Right | Switches to the next tab                                           |
|Normal  |Ctrl-Left  | Switches to the previous tab                                       |
|Normal  |Ctrl-Up    | Moves the current tab to the left                                  |
|Normal  |Ctrl-Down  | Moves the current tab to the right                                 |
|Normal  |Ctrl-o     | Increase the size of the current window.                           |
|Normal  |Ctrl-p     | Decrease the size of the current window.                           |
|Normal  |,o         | Insert line below current line and don't go into insert mode.      |
|Normal  |,p         | Insert line above current line and don't go into insert mode.      |
|Normal  |,l         | Insert a trace statement and then immediately go into insert mode. |
|Normal  |,k         | Insert a trace statement and don't go into insert mode.            |
|Insert  |Ctrl-Space | Starts autocompletion.                                             |

#### New commands

|User Input     | Description                                        |
|---------------|----------------------------------------------------|
|:FL<NUM>       | Set the foldlevel to `NUM`.                        |
|:mod           | Edit the vimrc                                     |
|:so            | Reload the vimrc                                   |
|:Man <command> | Open the man file for `command` in a split buffer. |

#### Notable Abbreviations

|String     | Description                      |
|-----------|----------------------------------|
|vs         |Vertically split buffer (vsplit). |
|te         |Edit a file in a tab. (tabedit).  |
