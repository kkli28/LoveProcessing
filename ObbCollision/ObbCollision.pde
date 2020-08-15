
class Vector
{
    float x;
    float y;
    float length;
    Vector(float _x, float _y)
    {
        x = _x;
        y = _y;
        length = sqrt(x * x + y * y);
    }
    Vector Add(Vector v)
    {
        return new Vector(x + v.x, y + v.y);
    }
    Vector Sub(Vector v)
    {
        return new Vector(x - v.x, y - v.y);
    }
    Vector Neg()
    {
        return new Vector(-x, -y);
    }
    float Dot(Vector v)
    {
        return x * v.x + y * v.y;
    }
    Vector Div(float f)
    {
        return new Vector(x / f, y / f);
    }
    float Proj(Vector v)
    {
        return abs(this.Dot(v) / v.length);
    }
}

class Rectangle
{
    float x;
    float y;
    float w;
    float h;
    float r;
    Vector vx;
    Vector vy;
    Rectangle(float _x, float _y, float _w, float _h, float _r)
    {
        x = _x;
        y = _y;
        w = _w;
        h = _h;
        r = _r;
        
        vx = new Vector(w / 2, 0);
        vy = new Vector(0, h / 2);
        UpdateV();
    }

    void AddRotation(float _dr)
    {
        r = r + _dr;
        UpdateV();
    }

    void UpdateV()
    {
        float halfW = w / 2;
        float halfH = h / 2;
        float sinR = sin(r);
        float cosR = cos(r);
        vx.x = halfW * cosR;
        vx.y = halfW * sinR;
        vy.y = halfH * cosR;
        vy.x = -halfH * sinR;
    }
    
    void Draw(boolean isCollide)
    {
        Vector p1 = new Vector(x, y).Add(vx.Neg()).Add(vy);
        Vector p2 = new Vector(x, y).Add(vx).Add(vy);
        Vector p3 = new Vector(x, y).Add(vx).Add(vy.Neg());
        Vector p4 = new Vector(x, y).Add(vx.Neg()).Add(vy.Neg());

        if (isCollide)
        {
            fill(#ff0000);
        }
        else
        {
            fill(#00ff00);
        }
        quad(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, p4.x, p4.y);
    }
}

class Sphere
{
    float x;
    float y;
    float r;
    Sphere(float _x, float _y, float _r)
    {
        x = _x;
        y = _y;
        r = _r;
    }

    void Draw(boolean isCollide)
    {
        if (isCollide)
        {
            fill(#ff0000);
        }
        else
        {
            fill(#00ff00);
        }
        ellipse(x, y, r * 2, r * 2);
    }
}

boolean IsCollide(Rectangle r1, Rectangle r2)
{
    Vector ab = new Vector(r1.x, r1.y).Sub(new Vector(r2.x, r2.y));
    ArrayList<Vector> list = new ArrayList<Vector>();
    list.add(r1.vx);
    list.add(r1.vy);
    list.add(r2.vx);
    list.add(r2.vy);
    for (int i = 0; i < 4; ++i)
    {
        Vector v = list.get(i);
        float len = ab.Proj(v) - r1.vx.Proj(v) - r1.vy.Proj(v) - r2.vx.Proj(v) - r2.vy.Proj(v);
        if (len > 0)
        {
            return false;
        }
    }
    return true;
}

boolean IsCollide(Rectangle r1, Sphere s2)
{
    Rectangle r = new Rectangle(r1.x, r1.y, r1.w, r1.h, 0);
    Vector ab = new Vector(s2.x - r.x, s2.y - r.y);
    float theta = atan2(ab.y, ab.x);
    theta = theta - r1.r;
    ab.x = abs(ab.length * cos(theta));
    ab.y = abs(ab.length * sin(theta));

    Vector h = ab.Sub(r.vx.Add(r.vy));
    if (h.x < 0)
    {
        h.x = 0;
    }
    if (h.y < 0)
    {
        h.y = 0;
    }
    if (s2.r > h.length)
    {
        return true;
    }
    return false;
}

float WIDTH = 800;
float HEIGHT = 800;

Rectangle baseRectangle = new Rectangle(WIDTH / 3, HEIGHT / 3, 200, 160, 0);
Sphere baseSphere = new Sphere(WIDTH * 2 / 3, HEIGHT * 2 / 3, 100);
Rectangle mouseRectangle = new Rectangle(100, 100, 160, 200, 0);

void setup()
{
    size(800, 800);
    background(255);
}

void draw()
{
    fill(255);
    rect(-1, -1, 802, 802);
    mouseRectangle.x = mouseX;
    mouseRectangle.y = mouseY;
    baseRectangle.AddRotation(0.02);
    mouseRectangle.AddRotation(0.04);
    baseRectangle.Draw(IsCollide(mouseRectangle, baseRectangle));
    baseSphere.Draw(IsCollide(mouseRectangle, baseSphere));
    mouseRectangle.Draw(false);
}
