---
layout: single
title: Vector Diagram in Qt QML
context: Ramblings
date: 2017-10-12 
categories: blog
comments: true
---


![Vector Diagram in Qt QML](/assets/images/polar_chart.gif)

I needed to plot vector diagram that is typical of a three-phase power system. I chose Qt because I was most comfortable with the framework. I quickly realized that there exists no such readily available QML element, so I decided to write my own. The code requires QtQuick 2 and Qt 5.5+

It uses [Context2D](http://doc.qt.io/qt-5/qml-qtquick-context2d.html) object to grab the context and draw simple lines along with the arrow head. I override the `onPaint` method. I use some trigonometry to calculate the length and displacement of each vector. There is a dynamically loaded `Text` element where I place descriptive text such as "V1" or "I1" to designate voltage or current. There is a timer that rotates through its full range of motion for testing purposes. 
 
I included a few links at the top of the source that helped me with the mathematics. Please let me know if you have any questions.

### VectorDia.qml

```
import QtQuick 2.0
import "qrc:/utility"

/*
 * Inspiration:
 *
 *   https://woboq.com/blog/animations-using-the-qtquick-canvas.html
 *   http://stackoverflow.com/questions/26044801/draw-na-arc-circle-sector-in-qml
 *   https://forum.qt.io/topic/56628/qml-canvas-dashed-dotted-lines/2
*/

Canvas {
    id: canvas
    width: 480
    height: 272 - 20

    signal rightMove()
    signal leftMove()
    signal loaded()

    Component.onCompleted: {
        canvas.onLoaded()
    }

    property int vVectorLength: 90
    property int iVectorLength: (.75 * vVectorLength)
    property real start_x: width/2
    property real start_y: 15
    property real end_x: width/2
    property real end_y: height - 15
    property bool dashed: true
    property real dash_length: 3
    property real dash_space: 4
    property real line_width: 0.9
    property real stipple_length: (dash_length + dash_space) > 0 ? (dash_length + dash_space) : 16
    property color draw_color: "black"

    property variant vectors: [0,30,120,120,240,210] // test vectors

    property variant alt: [0,0,0,0,0,0]
    property int i: 0

    property var comp;
    property   var text;


    Timer{ // test timer to paint random stuff
        interval: 500; running: true; repeat: true;
        onTriggered: {
            canvas.requestPaint()
        }
    }




    onPaint: {
        // Get the drawing context
        var ctx = canvas.getContext('2d')
        canvas.i = 0;
        for(var j = 0; j <canvas.alt.length; j++){
            if(alt[j]!== 0)
                alt[j].destroy();
        }

        ctx.fillStyle = "#ffffff"; // "erase" the previously drawn stuff
        ctx.fillRect(0,0,canvas.width,canvas.height,"#000000")

        // set line color
        ctx.strokeStyle = draw_color;
        ctx.lineWidth = line_width;
        ctx.beginPath();


        var centreX = canvas.width / 2;
        var centreY = canvas.height / 2;

        // draw the circle
        ctx.beginPath();
        ctx.lineWidth = 2
        ctx.fillStyle = "black";
        ctx.arc(centreX, centreY, (width / 4) - 10, 0, Math.PI * 2, false);
        ctx.stroke();

        // make the dashed lines
        drawDashed(ctx,start_x, start_y, end_x, end_y);
        drawDashed(ctx,130, height/2, width - 130, height/2);

        // draw the vectors
        drawVector(ctx, true, 1, vectors[0], "V<sub>1</sub>");
        drawVector(ctx, false, 1, vectors[1], "I<sub>1</sub>");
        drawVector(ctx, true, 2, vectors[2], "V<sub>2</sub>");
        drawVector(ctx, false, 2, vectors[3], "I<sub>2</sub>");
        drawVector(ctx, true, 3, vectors[4], "V<sub>3</sub>");
        drawVector(ctx, false, 3, vectors[5], "I<sub>3</sub>");

        var i;
        for(i = 0; i < vectors.length; i++){
            vectors[i] += 5; // add some degrees for demo
            if(vectors[i] > 360)
                vectors[i] -= 360
        }

    }

    // QML Math library uses radians and not degrees
    function degToRad(deg){
        return deg * (Math.PI/180);
    }




    function drawVector(ctx, isVoltage, phase, angle, label){ // no guards in place for parameters

        var centreX = canvas.width / 2;
        var centreY = canvas.height / 2;
        var vectorLength = isVoltage === true ? vVectorLength : iVectorLength; // current and voltage vectors diff length
        var color; // line color determined from which vector is being drawn

        if(phase === 1)
            color = "red";
        else if(phase === 2)
            color = "#e5e500";
        else if(phase === 3)
            color = "green";
        else
            color = "black";


        // draw the line
        ctx.strokeStyle = color;
        ctx.fillStyle= color;
        ctx.beginPath()
        var x = Math.cos(degToRad(angle)) * vectorLength;
        var y = Math.sin(degToRad(angle)) * vectorLength;
        ctx.moveTo(centreX, centreY)
        ctx.lineTo(x + centreX, y + centreY);
        ctx.stroke();

        // now draw the triangle
        // Derive the two points that make the triangle from the center point
        // by making a slighly short radius at a few degrees to the left and right
        // from the center point
        ctx.beginPath();
        var triCenterX = x + centreX;
        var triCenterY = y + centreY
        var leftX = Math.cos(degToRad(angle + 3)) * (vectorLength - 7);
        var leftY = Math.sin(degToRad(angle + 3)) * (vectorLength - 7);
        var rightX = Math.cos(degToRad(angle - 3)) * (vectorLength - 7);
        var rightY = Math.sin(degToRad(angle - 3)) * (vectorLength - 7);

        ctx.moveTo(triCenterX,triCenterY);
        ctx.lineTo(leftX + centreX, leftY + centreY);
        ctx.lineTo(rightX + centreX, rightY + centreY);
        ctx.closePath();
        ctx.fill(); // fill the triangle


        comp = Qt.createComponent("qrc:/utility/MyLabel.qml")

        if (comp.status === Component.Ready)
            finishCreation(angle,label,triCenterX,triCenterY);
        else
            comp.statusChanged.connect(finishCreation(angle,label,triCenterX,triCenterY));

    }

    // Now draw the text next to the arrows
    // Check which of the 4 quadrants we are in so that text placement
    // is optimal
    function finishCreation(angle,label,triCenterX,triCenterY) {
        if (comp.status === Component.Ready) {

            if(angle > 180 && angle < 360 )
                text = comp.createObject(canvas,{"x": triCenterX , "y": triCenterY -15});
               // text = comp.createObject(canvas,{"x": triCenterX, "y": triCenterY - 15});
            //if(angle > 270 && angle <= 360 )
              //  text = comp.createObject(canvas,{"x": triCenterX + 10, "y": triCenterY - 15});
            else //if(angle > 0 && angle <= 180 )
                text = comp.createObject(canvas,{"x": triCenterX, "y": triCenterY + 2});
            text.name = label;

            canvas.alt[canvas.i++] = text;

            if (text === null) {
                // Error Handling
                console.log("Error creating object");
            }
        } else if (comp.status === Component.Error) {
            // Error Handling
            console.log("Error loading component:", comp.errorString());
        }
    }


    function drawDashed(ctx,startX, startY, endX, endY){
        // make the dashed line
        var dashLen = stipple_length;
        var dX = endX - startX;
        var dY = endY - startY;
        var dashes = Math.floor(Math.sqrt(dX * dX + dY * dY) / dashLen);

        if (dashes == 0)
        {
            dashes = 1;
        }
        var dash_to_length = dash_length/dashLen
        var space_to_length = 1 - dash_to_length
        var dashX = dX / dashes;
        var dashY = dY / dashes;
        var x1 = startX;
        var y1 = startY;

        ctx.moveTo(x1,y1);

        var q = 0;
        while (q++ < dashes) {
            x1 += dashX*dash_to_length;
            y1 += dashY*dash_to_length;
            ctx.lineTo(x1, y1);
            x1 += dashX*space_to_length;
            y1 += dashY*space_to_length;
            ctx.moveTo(x1, y1);

        }
        ctx.stroke();
    }

    Text {
        id: text1
        x: 100
        y: 119
        text: qsTr("180°")
        font.pixelSize: 10
    }

    Text {
        id: text2
        x: 355
        y: 119
        width: 20
        height: 12
        text: qsTr("0°")
        font.pixelSize: 10
    }

    Text {
        id: text3
        x: 231
        y: 239
        text: qsTr("-90°")
        font.pixelSize: 10
    }



    Text {
        id: text4
        x: 233
        y: 2
        text: qsTr("90°")
        font.pixelSize: 10
    }


    Text {
        id: update
        x: 8
        y: 13
        text: qsTr("|")
        font.pixelSize: 20
        //verticalAlignment: Text.verticalCenter
        horizontalAlignment: Text.horizontalCenter
    }

    Timer{
        interval: 500 //500ms
        repeat: true
        running: true
        onTriggered: {
            if(update.text == "|")
                update.text = "/";
            else if(update.text == "/")
                update.text = "--";
            else if(update.text == "--")
                update.text = "\\"
            else if(update.text == "\\")
                update.text = "|"

        }
    }


}
```

### MyLabel.qml

```
import QtQuick 2.0

Text{
    id: textId
    property string name: "";
    text: textId.name
    textFormat: Text.RichText
    font.pixelSize: 12

    function destoryMe(){
        textId.destory()
    }
}
```








