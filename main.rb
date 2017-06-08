require 'opengl'
require 'glu'
require 'glut'
require 'chunky_png'
require 'wavefront'


require_relative 'model'


include Gl
include Glu
include Glut

FPS = 60.freeze
DELAY_TIME = (1000.0 / FPS)
DELAY_TIME.freeze

def load_objects
  puts "Loading model"
  @sun = Model.new('obj/sun', 'obj/sun.mtl')  
  # @mercury = Model.new('obj/mercury', 'obj/mercury.mtl')   
  # @venus = Model.new('obj/venus', 'obj/venus.mtl')      
  # @earth = Model.new('obj/earth', 'obj/earth.mtl')
  # @mars = Model.new('obj/mars', 'obj/mars.mtl')
  # @jupiter = Model.new('obj/jupiter', 'obj/jupiter.mtl')  
  # @saturn = Model.new('obj/saturn', 'obj/saturn.mtl')
  # @uranus = Model.new('obj/uranus', 'obj/uranus.mtl')
  # @neptune = Model.new('obj/neptune', 'obj/neptune.mtl')
  # @pluto = Model.new('obj/pluto', 'obj/pluto.mtl')
  @deathStar = Model.new('obj/deathStar', 'obj/deathStar.mtl')

  puts "model loaded"
end 

def initGL
  glDepthFunc(GL_LEQUAL)
  glEnable(GL_DEPTH_TEST)
  glClearDepth(1.0)
  
  glClearColor(0.0, 0.0, 0.0, 0.0)
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)

  glEnable(GL_LIGHTING)
  glEnable(GL_LIGHT0)
  glEnable(GL_COLOR_MATERIAL)
  glColorMaterial(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE)
  glEnable(GL_NORMALIZE)
  glShadeModel(GL_SMOOTH)
  glEnable(GL_CULL_FACE)
  glCullFace(GL_BACK)

  light_position = [0.0, 50.0, 100.0]
  light_color = [1.0, 1.0, 1.0, 1.0]
  specular = [1.0, 1.0, 1.0, 0.0]
  ambient = [0.15, 0.15, 0.15, 1.0]
  glLightfv(GL_LIGHT0, GL_POSITION, light_position)
  glLightfv(GL_LIGHT0, GL_DIFFUSE, light_color)
  glLightfv(GL_LIGHT0, GL_SPECULAR, specular)
  glLightModelfv(GL_LIGHT_MODEL_AMBIENT, ambient)
end

def draw
  @frame_start = glutGet(GLUT_ELAPSED_TIME)
  check_fps
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
 glPushMatrix
    glTranslate(0.0, 0.0, 0.0)
    glRotatef(@spinSun, 0.0, 3.0, 0.0)
    glScalef(12.0, 12.0, 12.0)
    @sun.draw
  glPopMatrix
#   glPushMatrix
#     glTranslate(@xMercury,0.0,@zMercury) #70
#     glRotatef(@spinMercury, 0.0, 3.0, 0.0)
#     glScalef(3.0, 3.0, 3.0)
#     @mercury.draw
#   glPopMatrix    
#   glPushMatrix
#     glTranslate(@xVenus, 0.0,@zVenus )
#     glRotatef(@spinVenus, 0.0, 3.0, 0.0)
#     glScalef(5, 5, 5)
#     @venus.draw
#   glPopMatrix
#   glPushMatrix
#     glTranslate(@xEarth, 0.0, @zEarth)
#     glRotatef(@spinEarth, 0.0, 1.0, 0.0)
#     glScalef(5.3, 5.3, 5.3)
#     @earth.draw
#   glPopMatrix
#   glPushMatrix
#     glTranslate(@xMars, 0.0, @zMars)
#     glRotatef(@spinMars, 0.0, 1.0, 0.0)
#     glScalef(5.0, 5.0, 5.0)
#     @mars.draw
#   glPopMatrix
#  glPushMatrix
#     glTranslate(@xJupiter, 0.0, @zJupiter)
#     glRotatef(@spinJupiter, 0.0, 3.0, 0.0)
#     glScalef(10.0, 10.0, 10.0)
#     @jupiter.draw
#   glPopMatrix
#   glPushMatrix
#     glTranslate(@xSaturn, 0.0, @zSaturn)
#     glRotatef(@spinSaturn, 0.0, 1.0, 0.0)
#     glScalef(21.0, 21.0, 21.0)
#     @saturn.draw
#   glPopMatrix
#   glPushMatrix
#     glTranslate(@xUranus, 0.0, @zUranus)
#     glRotatef(@spinUranus, 0.0, 3.0, 0.0)
#     glScalef(7.0, 7.0, 7.0)
#     @uranus.draw
#   glPopMatrix
#   glPushMatrix
#     glTranslate(@xNeptune, 0.0, @zNeptune)
#     glRotatef(@spinNeptune, 0.0, 3.0, 0.0)
#     glScalef(7.0, 7.0, 7.0)
#     @neptune.draw
#   glPopMatrix
#  glPushMatrix
#     glTranslate(@xPluto, 0.0, @zPluto)
#     glRotatef(@spinPluto, 0.0, 3.0, 0.0)
#     glScalef(4.0, 4.0, 4.0)
#     @pluto.draw
#   glPopMatrix
  glPushMatrix
    glTranslate(-260.0, 40.0, 0.0)
    glRotatef(160.0,  0.0, 3.0, 0.0)
    glScalef(0.3,0.3, 0.3)
    @deathStar.draw
  glPopMatrix

  glutSwapBuffers

end

def reshape(width, height)
  glViewport(0, 0, width, height)
  glMatrixMode(GL_PROJECTION)
  glLoadIdentity
  gluPerspective(45, (1.0 * width) / height, 0.001, 1500.0)
  glMatrixMode(GL_MODELVIEW)
  glLoadIdentity()
  # gluLookAt(1000.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0)#de frente
  gluLookAt(0.0, 1000.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0) #vista superior
  
  #  gluLookAt(1000.0, 180.0, -150.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0)

end

def idle
  # @spin = @spin + 1
  @spinMercury = @spinMercury + 0.017.to_f
  @spinVenus = @spinVenus + 0.00856.to_f
  @spinEarth = @spinEarth + ( 24 / 24 ).to_f
  @spinMars = @spinMars + 0.96.to_f
  @spinJupiter = @spinJupiter + ( 24 / 10 ).to_f
  @spinSaturn = @spinSaturn + ( 24 / 11 ).to_f
  @spinUranus = @spinUranus + ( 24 / 14 ).to_f
  @spinNeptune = @spinNeptune + ( 24 / 16 ).to_f
  @spinPluto = @spinPluto + 0.157.to_f
  @spinSun = @spinSun + 0.167.to_f
  
  if @spinMercury > 360.0
    @spinMercury = @spinMercury - 360.0
  end
  if @spinVenus > 360.0
    @spinVenus = @spinVenus - 360.0
  end
  if @spinEarth > 360.0
    @spinEarth = @spinEarth - 360.0
  end
  if @spinMars > 360.0
    @spinMars = @spinMars - 360.0
  end
  if @spinJupiter > 360.0
    @spinJupiter = @spinJupiter - 360.0
  end
  if @spinSaturn > 360.0
    @spinSaturn = @spinSaturn - 360.0
  end
  if @spinUranus > 360.0
    @spinUranus = @spinUranus - 360.0
  end
  if @spinNeptune > 360.0
    @spinNeptune = @spinNeptune- 360.0
  end 
  if @spinPluto > 360.0
    @spinPluto = @spinPluto - 360.0
  end
  if @spinSun > 360.0
    @spinSun = @spinSun - 360.0
  end
  
  
  @xMercury  = @radiusMercury*Math.sin(@wMercury*@t)
  @zMercury =  @radiusMercury*Math.cos(@wMercury*@t)
 
  @xVenus =  @radiusVenus*Math.sin(@wVenus*@t)
  @zVenus =  @radiusVenus*Math.cos(@wVenus*@t)
  
  @xEarth =  @radiusEarth*Math.sin(@wEarth*@t)
  @zEarth =  @radiusEarth*Math.cos(@wEarth*@t)
  
  @xMars =  @radiusMars*Math.sin(@wMars*@t)
  @zMars =  @radiusMars*Math.cos(@wMars*@t)

  @xJupiter =  @radiusJupiter*Math.sin(@wJupiter*@t)
  @zJupiter =  @radiusJupiter*Math.cos(@wJupiter*@t)

  @xSaturn =  @radiusSaturn*Math.sin(@wSaturn*@t)
  @zSaturn =  @radiusSaturn*Math.cos(@wSaturn*@t)
  
  @xUranus =  @radiusUranus*Math.sin(@wUranus*@t)
  @zUranus =  @radiusUranus*Math.cos(@wUranus*@t)
  
  @xNeptune =  @radiusNeptune*Math.sin(@wNeptune*@t)
  @zNeptune =  @radiusNeptune*Math.cos(@wNeptune*@t)
  
  @xPluto =  @radiusPluto*Math.sin(@wPluto*@t)
  @zPluto =  @radiusPluto*Math.cos(@wPluto*@t)

  
  @t = @t + 2
  @frame_time = glutGet(GLUT_ELAPSED_TIME) - @frame_start
  
  if (@frame_time< DELAY_TIME)
    sleep((DELAY_TIME - @frame_time) / 1000.0)
  end
  glutPostRedisplay
end

def check_fps
  current_time = glutGet(GLUT_ELAPSED_TIME)
  delta_time = current_time - @previous_time

  @frame_count += 1

  if (delta_time > 1000)
    fps = @frame_count / (delta_time / 1000.0)
    # puts "FPS: #{fps}"
    @frame_count = 0
    @previous_time = current_time
  end
end

@spin = 0.0
@spinMercury = 0.0
@spinVenus = 0.0
@spinEarth = 0.0
@spinMars = 0.0
@spinJupiter = 0.0
@spinSaturn = 0.0
@spinUranus = 0.0
@spinNeptune = 0.0
@spinPluto = 0.0
@spinSun = 0.0

@previous_time = 0
@frame_count = 0

@w=0.0047
@t=1.0

@xMercury=0.0
@zMercury=0.0
@radiusMercury = 70.0

@xVenus=0.0
@zVenus=0.0
@radiusVenus = 120

@xEarth=0.0
@zEarth=0.0
@radiusEarth = 170

@xMars=0.0
@zMars=0.0
@radiusMars = 230 

@xJupiter=0.0
@zJupiter=0.0
@radiusJupiter = 300

@xSaturn=0.0
@zSaturn=0.0
@radiusSaturn = 390

@xUranus=0.0
@zUranus=0.0
@radiusUranus = 470

@xNeptune=0.0
@zNeptune=0.0
@radiusNeptune = 540

@xPluto=0.0
@zPluto=0.0
@radiusPluto = 600

@wMercury= 0.00414
@wVenus= 0.00162
@wEarth= 0.001
@wMars= 0.000531
@wJupiter= 0.00008433
@wSaturn= 0.0000339
@wUranus= 0.0000119
@wNeptune= 0.00000606
@wPluto= 0.00000403

load_objects
glutInit
glutInitDisplayMode(GLUT_RGBA | GLUT_DOUBLE | GLUT_DEPTH)
glutInitWindowSize(1100,680)
glutInitWindowPosition(10,10)
glutCreateWindow("Hola OpenGL, en Ruby")
glutDisplayFunc :draw
glutReshapeFunc :reshape
glutIdleFunc :idle
initGL
glutMainLoop
