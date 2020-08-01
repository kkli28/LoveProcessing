int WIDTH = 1200;
int HEIGHT = 1200;
int CELL_SIZE = 24;
int XPOINT_COUNT = WIDTH / CELL_SIZE + 1;
int YPOINT_COUNT = HEIGHT / CELL_SIZE + 1;
int CIRCLE_COUNT = 16;

ArrayList<Circle> arrayCircles = new ArrayList<Circle>();
ArrayList<ArrayList<Point>> arrayPoints = new ArrayList<ArrayList<Point>>();
ArrayList<Table> loopUpTable = new ArrayList<Table>();
ArrayList<ArrayList<Cell>> arrayCells = new ArrayList<ArrayList<Cell>>();

class Table
{
    boolean b1;
    boolean b2;
    boolean b3;
    boolean b4;
    boolean r1;
    boolean r2;
    boolean r3;
    boolean r4;

    Table(boolean _b1, boolean _b2, boolean _b3, boolean _b4, boolean _r1, boolean _r2, boolean _r3, boolean _r4)
    {
        b1 = _b1;
        b2 = _b2;
        b3 = _b3;
        b4 = _b4;
        r1 = _r1;
        r2 = _r2;
        r3 = _r3;
        r4 = _r4;
    }
    float GetValueX(Point p1, Point p2)
    {
        float dx = p2.x - p1.x;
        float d = p1.depth + p2.depth;
        return p1.x + dx * (p1.depth / d);
    }
    float GetValueY(Point p1, Point p2)
    {
        float dy = p2.y - p1.y;
        float d = p1.depth + p2.depth;
        return p1.y + dy * (p1.depth / d);
    }
    void Draw(Cell cell)
    {
        float x1 = -1;
        float y1 = -1;
        float x2 = -1;
        float y2 = -1;
        if (r1 && r2 && r3 && r4)
        {
            if (b1 && b3)
            {
                x1 = GetValueX(cell.p1, cell.p2);
                y1 = cell.p1.y;
                x2 = cell.p2.x;
                y2 = GetValueY(cell.p2, cell.p3);
                line(x1, y1, x2, y2);
                x1 = GetValueX(cell.p3, cell.p4);
                y1 = cell.p3.y;
                x2 = cell.p1.x;
                y2 = GetValueY(cell.p1, cell.p4);
                line(x1, y1, x2, y2);
            }
            else
            {
                x1 = GetValueX(cell.p1, cell.p2);
                y1 = cell.p1.y;
                x2 = cell.p1.x;
                y2 = GetValueY(cell.p1, cell.p4);
                line(x1, y1, x2, y2);
                x1 = cell.p2.x;
                y1 = GetValueY(cell.p2, cell.p3);
                x2 = GetValueX(cell.p3, cell.p4);
                y2 = cell.p3.y;
                line(x1, y1, x2, y2);
            }
            line(x1, y1, x2, y2);
        }
        else
        {
            if (r1)
            {
                x1 = GetValueX(cell.p1, cell.p2);
                y1 = cell.p1.y;
            }
            if (r2)
            {
                if (x1 < 0)
                {
                    x1 = cell.p2.x;
                    y1 = GetValueY(cell.p2, cell.p3);
                }
                else
                {
                    x2 = cell.p2.x;
                    y2 = GetValueY(cell.p2, cell.p3);
                }
            }
            if (r3)
            {
                if (x1 < 0)
                {
                    x1 = GetValueX(cell.p3, cell.p4);
                    y1 = cell.p3.y;
                }
                else
                {
                    x2 = GetValueX(cell.p3, cell.p4);
                    y2 = cell.p3.y;
                }
            }
            if (r4)
            {
                if (x1 < 0)
                {
                    x1 = cell.p1.x;
                    y1 = GetValueY(cell.p1, cell.p4);
                }
                {
                    x2 = cell.p1.x;
                    y2 = GetValueY(cell.p1, cell.p4);
                }
            }
            line(x1, y1, x2, y2);
        }
    }
}

class Point {
    float x;
    float y;
    boolean inner;
    float depth;
    Point(float _x, float _y)
    {
        x = _x * CELL_SIZE;
        y = _y * CELL_SIZE;
        inner = false;
        depth = 0;
    }
    void Draw()
    {
        ellipse(x, y, 2, 2);
    }
}

class Circle
{
    float x;
    float y;
    float r;
    float vx;
    float vy;

    Circle(float _x, float _y, float _r, float _vx, float _vy)
    {
        x = _x;
        y = _y;
        r = _r;
        vx = _vx;
        vy = _vy;
    }
    void Draw()
    {
        ellipse(x, y, r * 2, r * 2);
    }
    void Move()
    {
        x = x + vx;
        y = y + vy;
        if (x < r)
        {
            x = r;
            vx = -vx;
        }
        else if (x > WIDTH - r)
        {
            x = WIDTH - r;
            vx = -vx;
        }
        if (y < r)
        {
            y = r;
            vy = -vy;
        }
        else if (y > HEIGHT - r)
        {
            y = HEIGHT - r;
            vy = -vy;
        }
    }
}

class Cell
{
    Point p1;
    Point p2;
    Point p3;
    Point p4;
    Cell(Point _p1, Point _p2, Point _p3, Point _p4)
    {
        p1 = _p1;
        p2 = _p2;
        p3 = _p3;
        p4 = _p4;
    }
    void Draw()
    {
        Table t = findTable(this);
        t.Draw(this);
    }
}

void setup()
{
    size(1200, 1200);
    init();
}

void init()
{
    loopUpTable.add(new Table(false, false, false, false, false, false, false, false));
    loopUpTable.add(new Table(true, false, false, false, true, false, false, true));
    loopUpTable.add(new Table(false, true, false, false, true, true, false, false));
    loopUpTable.add(new Table(true, true, false, false, false, true, false, true));

    loopUpTable.add(new Table(false, false, true, false, false, true, true, false));
    loopUpTable.add(new Table(true, false, true, false, true, true, true, true));
    loopUpTable.add(new Table(false, true, true, false, true, false, true, false));
    loopUpTable.add(new Table(true, true, true, false, false, false, true, true));

    loopUpTable.add(new Table(false, false, false, true, false, false, true, true));
    loopUpTable.add(new Table(true, false, false, true, true, false, true, false));
    loopUpTable.add(new Table(false, true, false, true, true, true, true, true));
    loopUpTable.add(new Table(true, true, false, true, false, true, true, false));

    loopUpTable.add(new Table(false, false, true, true, false, true, false, true));
    loopUpTable.add(new Table(true, false, true, true, true, true, false, false));
    loopUpTable.add(new Table(false, true, true, true, true, false, false, true));
    loopUpTable.add(new Table(true, true, true, true, false, false, false, false));

    for (int i = 0; i < XPOINT_COUNT; ++i)
    {
        ArrayList<Point> array = new ArrayList<Point>();
        arrayPoints.add(array);
        for (int j = 0; j < YPOINT_COUNT; ++j)
        {
            array.add(new Point(i, j));
        }
    }
    for (int i = 0; i < XPOINT_COUNT - 1; ++i)
    {
        ArrayList<Cell> cells = new ArrayList<Cell>();
        arrayCells.add(cells);
        for (int j = 0; j < YPOINT_COUNT - 1; ++j)
        {
            Point p1 = arrayPoints.get(j).get(i);
            Point p2 = arrayPoints.get(j+1).get(i);
            Point p3 = arrayPoints.get(j+1).get(i+1);
            Point p4 = arrayPoints.get(j).get(i+1);
            cells.add(new Cell(p1, p2, p3, p4));
        }
    }

    for (int i = 0; i < CIRCLE_COUNT; ++i)
    {
        float vx = random(0.5, 2);
        float vy = random(0.5, 2);
        arrayCircles.add(new Circle(random(200, WIDTH - 200), random(200, HEIGHT - 200), random(60, 120), random(-vx, vx), random(-vy, vy)));
    }
}

void draw()
{
    background(255);

    // move & calc
    circleMove();
    calcPoints();

    // draw
    fill(0);
    stroke(224);
    strokeWeight(1);
    drawGrids();

    stroke(192);
    drawPoints();

    noFill();
    stroke(192);
    drawCircles();

    stroke(#00ff00);
    strokeWeight(4);
    drawCells();
}

void circleMove()
{
    for (int i = 0; i < CIRCLE_COUNT; ++i)
    {
        arrayCircles.get(i).Move();
    }
}

void calcPoints()
{
    for (int i = 0; i < XPOINT_COUNT; ++i)
    {
        for (int j = 0; j < YPOINT_COUNT; ++j)
        {
            Point p = arrayPoints.get(i).get(j);
            p.inner = false;
            p.depth = 99999;
            for (int x = 0; x < CIRCLE_COUNT; ++x)
            {
                Circle c = arrayCircles.get(x);
                float dx = c.x - p.x;
                float dy = c.y - p.y;
                float d = sqrt(dx * dx + dy * dy);
                if (d < c.r)
                {
                    p.inner = true;
                }
                float depth = d - c.r;
                if (depth < p.depth)
                {
                    p.depth = depth;
                }
            }
            p.depth = abs(p.depth);
        }
    }
}

void drawGrids()
{
    for (int i = 0; i < XPOINT_COUNT; ++i)
    {
        float y = i * CELL_SIZE;
        line(0, y, WIDTH, y);
    }
    for (int j = 0; j < YPOINT_COUNT; ++j)
    {
        float x = j * CELL_SIZE;
        line(x, 0, x, HEIGHT);
    }
}

void drawPoints()
{
    for (int i = 0; i < XPOINT_COUNT; ++i)
    {
        for (int j = 0; j < YPOINT_COUNT; ++j)
        {
            Point p = arrayPoints.get(i).get(j);
            if (p.inner)
            {
                p.Draw();
            }
        }
    }
}

void drawCircles()
{
    for (int i = 0; i < CIRCLE_COUNT; ++i)
    {
        arrayCircles.get(i).Draw();
    }
}

void drawCells()
{
    for (int i = 0; i < XPOINT_COUNT - 1; ++i)
    {
        for (int j = 0; j < YPOINT_COUNT - 1; ++j)
        {
            arrayCells.get(i).get(j).Draw();
        }
    }
}

Table findTable(Cell cell)
{
    for (int i = 0; i < 16; ++i)
    {
        Table t = loopUpTable.get(i);
        if ((t.b1 == cell.p1.inner) && (t.b2 == cell.p2.inner) && (t.b3 == cell.p3.inner) && (t.b4 == cell.p4.inner))
        {
            return t;
        }
    }
    return null;
}
