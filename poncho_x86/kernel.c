void _start() {

    unsigned char *video_mem = (unsigned char *)0xb8000;

    *video_mem = 'H';
    video_mem += 2;
    *video_mem = 'e';
    video_mem += 2;
    *video_mem = 'l';
    video_mem += 2;
    *video_mem = 'l';
    video_mem += 2;
    *video_mem = 'o';
    video_mem += 2;
    *video_mem = ',';
    video_mem += 2;
    *video_mem = ' ';
    video_mem += 2;
    *video_mem = 'w';
    video_mem += 2;
    *video_mem = 'o';
    video_mem += 2;
    *video_mem = 'r';
    video_mem += 2;
    *video_mem = 'l';
    video_mem += 2;
    *video_mem = 'd';
    video_mem += 2;
    *video_mem = '!';
    video_mem += 2;

    return;
}