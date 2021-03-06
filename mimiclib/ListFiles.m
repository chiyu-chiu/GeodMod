function [outfiles] = ListFiles(infiles)
% 
% List files linewise.  Used instead of dir( ) when input string contains
% [0-9].
% 
% test by running
% a=ListFiles('/RAID6/insar_lab/testdata_geodmod/ML2002-2005/Data/RsatD1/geo*[0-9].unw')
%
% Note: We need to use ls() instead of dir() because dir('geo*[0-9].unw') does not work.
%
% Windows-linux problem: Under linux ls returns the entire path. Under Windows it just returns the filename. This is why
% we strip the path from the file and than put it back.
%
% Note: I did not understand the matlab help command regarding windows specific ls output.
% Note: matlab help says that the output of the fileparts is filespecific. For saftey and compatibility it
%       extracts versn though I never saw that versn was not empty
% 
% FA March 2008: Adjusted for Windows

tmpstr = ls(infiles) ;  tmpcellarray1 = textscan(tmpstr,'%s') ;  tmpcellarray2= tmpcellarray1{1} ;

[pathstr,name,ext] = fileparts(infiles);

for ni=1:size(tmpcellarray2,1)
    [j, name,ext] = fileparts(tmpcellarray2{ni});         % stripping off path because of liunx-windows problem (j is empty under Windows)
    if ~isempty(j)
        outfiles(ni).name   = fullfile(j,[name ext]);
    else
        outfiles(ni).name   = fullfile(pathstr,[name ext]);   % putting back path (under linux pathstr equals j but not under Windows)
    end
end
