clear;
close all;

mapname(1)  = {'autumn'};
mapname(2)  = {'bone'};
mapname(3)  = {'colorcube'};
mapname(4)  = {'cool'};
mapname(5)  = {'copper'};
mapname(6)  = {'flag'};
mapname(7)  = {'gray'};
mapname(8)  = {'hot'};
mapname(9)  = {'hsv'};
mapname(10) = {'jet'};
mapname(11) = {'pink'};
mapname(12) = {'prism'};
mapname(13) = {'spring'};
mapname(14) = {'summer'};
mapname(15) = {'winter'};
mapname(16) = {'parula'};

destdir = '~/';

for i=1:16
    colormap(char(mapname(i)))
    map = colormap;
    colorbar
    title(char(mapname(i)))
    drawnow;
    pause(1);
    outname = sprintf('%s/%s.map',destdir,char(mapname(i)));
    fid = fopen(outname,'w');
    if (fid == -1)
        error('cant open map file')
    end

    fprintf(fid, '#!MC 900\n$!COLORMAP\n  CONTOURCOLORMAP = USERDEF\n');
    fprintf(fid, '$!COLORMAPCONTROL RESETTOFACTORY\n$!COLORMAP\n  USERDEFINED\n');
    fprintf(fid, '    {\n    NUMCONTROLPOINTS = 22\n');

    for i = 1:3:64
        fprintf(fid, '    CONTROLPOINT %d\n',(i-1)/3+1);
        fprintf(fid, '      {\n      COLORMAPFRACTION = %f\n',(i-1)/63);
        fprintf(fid, '      LEADRGB\n');
        fprintf(fid, '        {\n');
        fprintf(fid, '        R = %d\n',round(map(i,1)*255));
        fprintf(fid, '        G = %d\n',round(map(i,2)*255));
        fprintf(fid, '        B = %d\n',round(map(i,3)*255));
        fprintf(fid, '        }\n');
        fprintf(fid, '      TRAILRGB\n');
        fprintf(fid, '        {\n');
        fprintf(fid, '        R = %d\n',round(map(i,1)*255));
        fprintf(fid, '        G = %d\n',round(map(i,2)*255));
        fprintf(fid, '        B = %d\n',round(map(i,3)*255));
        fprintf(fid, '        }\n');
        fprintf(fid, '      }\n');
    end

    fprintf(fid, '    }\n');

    fclose(fid);



end