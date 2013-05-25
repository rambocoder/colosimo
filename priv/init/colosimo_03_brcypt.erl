-module(colosimo_03_bcrypt). 
-export([init/0, stop/0]). 

init() -> 
     bcrypt:start(). 

stop() -> 
     bcrypt:stop(). 
%% 
