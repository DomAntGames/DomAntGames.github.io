extern float transparency;
extern int shift;
extern vec4 baseColors[6];
extern vec4 activeColors[6];

int imax ( int i1, int i2 )
{
  return i1 > i2 ? i1 : i2;
}
int imin ( int i1, int i2 )
{
  return i1 < i2 ? i1 : i2;
}

vec4 effect( vec4 col, Image texture, vec2 texturePos, vec2 screenPos )
{
    vec4 raw   = Texel ( texture, texturePos );
    vec4 color = vec4  (0,0,0,raw.a);  

    color     += int(raw == baseColors[5]) * activeColors[int(imax(imin(5+shift,5),1))];
    color     += int(raw == baseColors[4]) * activeColors[int(imax(imin(4+shift,5),1))];
    color     += int(raw == baseColors[3]) * activeColors[int(imax(imin(3+shift,5),1))];
    color     += int(raw == baseColors[2]) * activeColors[int(imax(imin(2+shift,5),1))];
    color     += int(raw == baseColors[1]) * activeColors[int(imax(imin(1+shift,5),1))];
    color     += int(raw == baseColors[0]) * activeColors[0];
    color.a    = color.a*transparency;
    return color;
}