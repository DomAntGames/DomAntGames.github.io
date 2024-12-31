extern float transparency;
extern int shift;
extern vec4 baseColors[6];
extern vec4 activeColors[6];

extern float time;           // passage of time
extern float sinTime;
extern float cellDensity = 25;

extern float strength = 0.005;
float speed           = 0.125;
float angleOffset     = 30; 
float angleSpeed      = 10;

/////////////
// VORONOI //
/////////////
const mat2 myt = mat2(.12121212, .13131313, -.13131313, .12121212);
const vec2 mys = vec2(1e4, 1e6);

vec2 rhash ( vec2 uv ) {
  uv *= myt;
  uv *= mys;
  return fract(fract(uv / mys) * uv);
}

float voronoi ( const in vec2 point ) {
  vec2 p = floor ( point );
  vec2 f = fract ( point );
  float res = 0.0;

  // unrolled loop by hand, prolly not necessary. Oh well!
  // -1
  vec2 b = vec2 ( -1, -1 );
  vec2 r = vec2 ( b ) - f + rhash ( p + b );
  res    = res + 1. / pow ( dot ( r, r ), 8. );

  b     = vec2 ( -1, 0 );
  r     = vec2 ( b ) - f + rhash ( p + b );
  res   = res + 1. / pow ( dot ( r, r ), 8. );

  b     = vec2 ( -1, 1 );
  r     = vec2 ( b ) - f + rhash ( p + b );
  res   = res + 1. / pow ( dot ( r, r ), 8. );

  // 0
  b     = vec2 ( 0, -1 );
  r     = vec2 ( b ) - f + rhash ( p + b );
  res   = res + 1. / pow ( dot ( r, r ), 8. );

  b     = vec2 ( 0, 0 );
  r     = vec2 ( b ) - f + rhash ( p + b );
  res   = res + 1. / pow ( dot ( r, r ), 8. );

  b     = vec2 ( 0, 1 );
  r     = vec2 ( b ) - f + rhash ( p + b );
  res   = res + 1. / pow ( dot ( r, r ), 8. );

  // 1
  b     = vec2 ( 1, -1 );
  r     = vec2 ( b ) - f + rhash ( p + b );
  res   = res + 1. / pow ( dot ( r, r ), 8. );

  b     = vec2 ( 1, 0 );
  r     = vec2 ( b ) - f + rhash ( p + b );
  res   = res + 1. / pow ( dot ( r, r ), 8. );

  b     = vec2 ( 1, 1 );
  r     = vec2 ( b ) - f + rhash ( p + b );
  res   = res + 1. / pow ( dot ( r, r ), 8. );

  return pow ( 1. / res, 0.0625 );
}

int imax ( int i1, int i2 )
{
  return i1 > i2 ? i1 : i2;
}
int imin ( int i1, int i2 )
{
  return i1 < i2 ? i1 : i2;
}

/////////////////
// main shader //
/////////////////
vec4 effect ( vec4 col, Image texture, vec2 texturePos, vec2 screenPos )
{
    vec2  noiseUV   = texturePos.xy - vec2 ( 0, time * speed );
    float angle     = angleOffset + sinTime * angleSpeed;
    float noise     = voronoi ( noiseUV * angle * cellDensity );
    float offset    = noise * strength;

    vec2 coord      = texturePos;
    coord.x         = coord.x + offset;

    vec4 raw   = Texel ( texture, coord );
    vec4 color = vec4  (0,0,0,raw.a);  

    color     += int(raw == baseColors[5]) * activeColors[int(imax(imin(5+shift,5),1))];
    color     += int(raw == baseColors[4]) * activeColors[int(imax(imin(4+shift,5),1))];
    color     += int(raw == baseColors[3]) * activeColors[int(imax(imin(3+shift,5),1))];
    color     += int(raw == baseColors[2]) * activeColors[int(imax(imin(2+shift,5),1))];
    color     += int(raw == baseColors[1]) * activeColors[int(imax(imin(1+shift,5),1))];
    color     += int(raw == baseColors[0]) * activeColors[0];
    color.a    = color.a * transparency;
    
    return vec4  ( color.r, color.g, color.b, color.a ); 
}