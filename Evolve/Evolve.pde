import java.util.*;
boolean printed = false;
int generations = 0;
float[] dist = new float[5];

ArrayList < ball > balls = new ArrayList();
ball ball;
box box;
void setup() {


    fullScreen();
    box = new box();


    for (int numbOfBalls = 0; numbOfBalls < 5; numbOfBalls++) {
        int[] dirs = new int[100];
        for (int dir = 0; dir < 99; dir++) {
            dirs[dir] = int(random(0, 5));
        }
        balls.add(new ball(dirs));

    }




    int[] dirs = new int[100];
    for (int dir = 0; dir < 99; dir++) {
        dirs[dir] = int(random(0, 5));
    }
    ball = new ball(dirs);
}


void draw() {


    for (int numbOfBalls = 0; numbOfBalls < 5; numbOfBalls++) {
        if (balls.get(numbOfBalls).going) {
            balls.get(numbOfBalls).move();
        }
        if (balls.get(numbOfBalls).moves > 98 && balls.get(numbOfBalls).going) {
            dist[numbOfBalls] = balls.get(numbOfBalls).distance;
            balls.get(numbOfBalls).going = !balls.get(numbOfBalls).going;

            if (numbOfBalls == 4) {
                Arrays.sort(dist);
                println("");
                println("Best Boyz");
                println("");
                println(dist[0]);
                println(dist[1]);
                println("");
                println("New Generation");



                int[] dna1 = new int[100], dna2 = new int[100];

                for (int ball = 0; ball < 5; ball++) {
                    if (dist[0] == balls.get(ball).distance) {
                        dna1 = balls.get(ball).direction;
                    }
                }

                for (int ball = 0; ball < 5; ball++) {
                    if (dist[1] == balls.get(ball).distance) {
                        dna2 = balls.get(ball).direction;
                    }
                }

                balls = new ArrayList();

                balls.add(new ball(dna1));

                balls.add(new ball(dna2));
                
                balls.add(new ball(mutate(dna1)));

                balls.add(new ball(mutate(dna2)));

                balls.add(new ball(mutate((random(0, 2) == 1) ? dna1 : dna2)));




            }
        }
    }



}


int[] mutate(int[] dna) {


int[] dirs = new int[100];
        for (int dir = 0; dir < 99; dir++) {
            dirs[dir] = int(random(0, 5));
        }
        
        for(int i = 0; i<90; i++){
          int gene = int(random(100));
dirs[gene] = dna[gene];
}

    return dirs;
}



class ball {
    int xPos = 0, yPos = 0;
    int[] direction = new int[100];
    int moves = 0;
    boolean going = true;
    float distance;

    ball(int[] dir) {
        direction = dir;
    }

    void setMoves() {}


    void move() {
        delay(10);
        moves++;
        if (direction[moves] == 1) {
            yPos = yPos + 50;
        } else
        if (direction[moves] == 2) {
            yPos = yPos - 50;
        } else
        if (direction[moves] == 3) {
            xPos = xPos + 50;
        } else
        if (direction[moves] == 4) {
            xPos = xPos - 50;
        }
        clear();
        circle(xPos, yPos, 10);
        box.Draw();
        distance = sqrt(sq(float(abs(xPos - box.xPos))) + sq(float(abs(yPos - box.yPos))));

        if (moves > 98) {
            println(distance);
        }
    }
}


class box {
    int xPos = width / 2;
    int yPos = height / 2;

    box() {}

    void Draw() {
        square(xPos, yPos, 10);
    }
}
