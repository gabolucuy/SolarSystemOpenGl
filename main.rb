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
  @mercury = Model.new('obj/mercury', 'obj/mercury.mtl')    
  # @venus = Model.new('obj/venus', 'obj/venus.mtl')      
  # @earth = Model.new('obj/earth', 'obj/earth.mtl')
  # @mars = Model.new('obj/mars', 'obj/mars.mtl')
  # @jupiter = Model.new('obj/jupiter', 'obj/jupiter.mtl')  
  # @saturn = Model.new('obj/saturn', 'obj/saturn.mtl')
  # @uranus = Model.new('obj/uranus', 'obj/uranus.mtl')
  # @neptune = Model.new('obj/neptune', 'obj/neptune.mtl')
  # @pluto = Model.new('obj/pluto', 'obj/pluto.mtl')
  
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
    glRotatef(0.0, 0.0, 3.0, 0.0)
    glScalef(12.0, 12.0, 12.0)
    @sun.draw
  glPopMatrix
  glPushMatrix
    glTranslate(@xMercury, @zMercury, 0.0) #70
    glRotatef(@spin, 0.0, 3.0, 0.0)
    glScalef(3.0, 3.0, 3.0)
    @mercury.draw
  glPopMatrix
#   glPushMatrix
#     glTranslate(0.0, 0.0, 120.0)
#     glRotatef(@spin, 0.0, 3.0, 0.0)
#     glScalef(5, 5, 5)
#     @venus.draw
#   glPopMatrix
#   glPushMatrix
#     glTranslate(0.0, 0.0, 170.0)
#     glRotatef(@spin, 0.0, 1.0, 0.0)
#     glScalef(5.3, 5.3, 5.3)
#     @earth.draw
#   glPopMatrix
#   glPushMatrix
#     glTranslate(0.0, 0.0, 230.0)
#     glRotatef(@spin, 0.0, 1.0, 0.0)
#     glScalef(5.0, 5.0, 5.0)
#     @mars.draw
#   glPopMatrix
#  glPushMatrix
#     glTranslate(0.0, 0.0, 300.0)
#     glRotatef(@spin, 0.0, 3.0, 0.0)
#     glScalef(10.0, 10.0, 10.0)
#     @jupiter.draw
#   glPopMatrix
#   glPushMatrix
#     glTranslate(0.0, 0.0, 390.0)
#     glRotatef(@spin, 0.0, 1.0, 0.0)
#     glScalef(18.0, 18.0, 18.0)
#     @saturn.draw
#   glPopMatrix
#   glPushMatrix
#     glTranslate(0.0, 0.0, 470.0)
#     glRotatef(@spin, 0.0, 3.0, 0.0)
#     glScalef(7.0, 7.0, 7.0)
#     @uranus.draw
#   glPopMatrix
#   glPushMatrix
#     glTranslate(0.0, 0.0, 540.0)
#     glRotatef(@spin, 0.0, 3.0, 0.0)
#     glScalef(7.0, 7.0, 7.0)
#     @neptune.draw
#   glPopMatrix
# glPushMatrix
#     glTranslate(0.0, 0.0, 600.0)
#     glRotatef(@spin, 0.0, 3.0, 0.0)
#     glScalef(4.0, 4.0, 4.0)
#     @pluto.draw
#   glPopMatrix

  glutSwapBuffers

end

def reshape(width, height)
  glViewport(0, 0, width, height)
  glMatrixMode(GL_PROJECTION)
  glLoadIdentity
  gluPerspective(45, (1.0 * width) / height, 0.001, 1000.0)
  glMatrixMode(GL_MODELVIEW)
  glLoadIdentity()
  gluLookAt(0.0, 1000.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0)
end

def idle
  @spin = @spin + 1

  if @spin > 360.0
    @spin = @spin - 360.0
  
  
  @xMercury =  @radioMercury*Math.cos(@w*@t)
  @zMercury =  @radioMercury*Math.sin(@w*@t)
  
  end

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
    puts "FPS: #{fps}"
    @frame_count = 0
    @previous_time = current_time
  end
end

@spin = 0.0
@previous_time = 0
@frame_count = 0
@xMercury=0
@zMercury=0
@radioMercury = 70
@t=1
@w=0.0047
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
