-- Mixin responsible for everything drawing related. This mixin is the only way you can draw something to the screen.
-- Draw commands are sent to the layer's queue of commands and then drawn to a canvas at the end of the frame.
-- Create a new layer like so:
--   game = layer()
-- And then in an update function somewhere:
--   game:circle(50, 50, 10, colors.white[0])
-- This sends a draw command to the game layer telling it to draw a circle at 50, 50 with radius 10 and white color.
-- At the end of the frame the circle is drawn and all draw commands cleared so they can be added anew next frame. Layers are drawn in the order they were created.
-- A layer can also be created with a table that specifies different behaviors:
--   game = layer({attribute = value, ...})
-- Possible attributes are:
--   * fixed - by default layers are drawn modified by main.camera's transform; fixed being true disables this, which is useful for things like UIs which don't need to be affected by any camera
local graphics = {}
local layer = class:class_new()
function layer:layer_init(x, y)
  self.x, self.y = x, y
  self.layer_canvas = love.graphics.newCanvas(main.w, main.h)
  self.draw_commands = {}
  table.insert(main.layer_objects, self)
  return self
end

-- Both :layer_draw_to and :layer_draw should be called in order to draw the layer completely.
-- They are separated because in some cases you might want to draw the commands to the layer's canvas, do some other actions, and then draw the layer to main.canvas.
function layer:layer_draw()
  main:draw_canvas(self.layer_canvas, self.x, self.y, 0, main.sx, main.sy)
end

function layer:layer_draw_to()
  main:draw_to_canvas(self.layer_canvas, function() self:layer_draw_commands() end)
end

local z_sort = function(a, b) return (a.z or 0) < (b.z or 0) end
function layer:layer_draw_commands()
  table.stable_sort(self.draw_commands, z_sort)
  if not self.fixed then main.camera:camera_attach() end
  for _, command in ipairs(self.draw_commands) do
    if graphics[command.type] then
      graphics[command.type](unpack(command.args))
    else
      error('undefined layer graphics function for ' .. command.type)
    end
  end
  if not self.fixed then main.camera:camera_detach() end
end


-- Draws a circle of radius r centered on x, y.
-- If color is passed in then the circle will be filled with that color (color is Color object)
-- If line_width is passed in then the circle will not be filled and will instead be drawn as a set of lines of the given width.
function graphics.circle(x, y, r, color, line_width)
  graphics.shape("circle", color, line_width, x, y, r)
end

function layer:circle(x, y, r, color, line_width, z)
  table.insert(self.draw_commands, {type = 'circle', args = {x, y, r, color, line_width}, z = z or 0})
end

-- Draws a dashed line with the given points.
-- dash_size and gap_size correspond to the dimensions of the dashing behavior.
-- If color is passed in then the lines will be filled with that color (color is Color object)
-- If line_width is passed in then the lines will not be filled and will instead be drawn as a set of lines of the given width.
function graphics.dashed_line(x1, y1, x2, y2, dash_size, gap_size, color, line_width)
  local r, g, b, a = love.graphics.getColor()
  if color then love.graphics.setColor(color.r, color.g, color.b, color.a) end
  if line_width then love.graphics.setLineWidth(line_width) end
  local dx, dy = x2-x1, y2-y1
  local an, st = math.atan2(dy, dx), dash_size + gap_size
  local len = math.sqrt(dx*dx + dy*dy)
  local nm = (len-dash_size)/st
  love.graphics.push()
    love.graphics.translate(x1, y1)
    love.graphics.rotate(an)
    for i = 0, nm do love.graphics.line(i*st, 0, i*st + dash_size, 0) end
    love.graphics.line(nm*st, 0, nm*st + dash_size, 0)
  love.graphics.pop()
end

function layer:dashed_line(x1, y1, x2, y2, dash_size, gap_size, color, line_width, z)
  table.insert(self.draw_commands, {type = 'dashed_line', args = {x1, y1, x2, y2, dash_size, gap_size, color, line_width}, z = z or 0})
end

function graphics.draw(drawable, x, y, r, sx, sy, ox, oy)
  love.graphics.draw(drawable.object, x, y, r, sx, sy, ox, oy)
end

function layer:draw(drawable, x, y, r, sx, sy, ox, oy, z)
  table.insert(self.draw_commands, {type = 'draw', args = {drawable, x, y, r, sx, sy, ox, oy}, z = z or 0})
end

function graphics.draw_canvas(canvas, x, y, r, sx, sy, color, shader, flat)
  local color = color or colors.white[0]
  if shader then love.graphics.setShader(shader) end
  if flat then
    love.graphics.setColor(color.r, color.g, color.b, color.a)
    love.graphics.draw(canvas, x or 0, y or 0, r or 0, sx or 1, sy or sx or 1)
  else
    love.graphics.setColor(color.r, color.g, color.b, color.a)
    love.graphics.setBlendMode('alpha', 'premultiplied')
    love.graphics.draw(canvas, x or 0, y or 0, r or 0, sx or 1, sy or sx or 1)
    love.graphics.setBlendMode('alpha')
  end
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.setShader()
end

function layer:draw_canvas(canvas, x, y, r, sx, sy, color, shader, flat)
  table.insert(self.draw_commands, {type = 'draw_canvas', args = {canvas, x, y, r, sx, sy, color, shader, flat}, z = z or 0})
end

function graphics.draw_image(drawable, x, y, r, sx, sy, ox, oy, color, shader)
  local _r, g, b, a
  if color then
    _r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(color.r, color.g, color.b, color.a)
  end
  if shader then love.graphics.setShader(shader) end
  love.graphics.draw(drawable.object, x, y, r or 0, sx or 1, sy or sx or 1, drawable.w*0.5 + (ox or 0), drawable.w*0.5 + (oy or 0))
  if shader then love.graphics.setShader() end
  if color then love.graphics.setColor(_r, g, b, a) end
end

function layer:draw_image(drawable, x, y, r, sx, sy, ox, oy, color, shader, z)
  table.insert(self.draw_commands, {type = 'draw_image', args = {drawable, x, y, r, sx, sy, ox, oy, color, shader}, z = z or 0})
end

function graphics.draw_quad(drawable, quad, x, y, r, sx, sy, ox, oy, color, shader)
  local _r, g, b, a
  if color then
    _r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(color.r, color.g, color.b, color.a)
  end
  if shader then love.graphics.setShader(shader) end
  love.graphics.draw(drawable.object, quad, x, y, r or 0, sx or 1, sy or sx or 1, ox, oy)
  if shader then love.graphics.setShader() end
  if color then love.graphics.setColor(_r, g, b, a) end
end

function layer:draw_quad(drawable, quad, x, y, r, sx, sy, ox, oy, color, shader, z)
  table.insert(self.draw_commands, {type = 'draw_quad', args = {drawable, quad, x, y, r, sx, sy, ox, oy, color, shader}, z = z or 0})
end

-- Prints text to the screen, alternative to using an object with a text mixin.
function graphics.draw_text(text, font, x, y, r, sx, sy, ox, oy, color)
  local _r, g, b, a = love.graphics.getColor()
  if color then love.graphics.setColor(color.r, color.g, color.b, color.a) end
  love.graphics.print(text, font.object, x, y, r or 0, sx or 1, sy or 1, ox or 0, oy or 0)
  if color then love.graphics.setColor(_r, g, b, a) end
end

function layer:draw_text(text, font, x, y, r, sx, sy, ox, oy, color, z)
  table.insert(self.draw_commands, {type = 'draw_text', args = {text, font, x, y, r, sx, sy, ox, oy, color}, z = z or 0})
end

-- Prints text to the screen centered on x, y, alternative to using an object with a text mixin.
function graphics.draw_text_centered(text, font, x, y, r, sx, sy, ox, oy, color)
  local _r, g, b, a = love.graphics.getColor()
  if color then love.graphics.setColor(color.r, color.g, color.b, color.a) end
  love.graphics.print(text, font.object, x, y, r or 0, sx or 1, sy or 1, (ox or 0) + font:font_get_width(text)/2, (oy or 0) + font.h/2)
  if color then love.graphics.setColor(_r, g, b, a) end
end

function layer:draw_text_centered(text, font, x, y, r, sx, sy, ox, oy, color, z)
  table.insert(self.draw_commands, {type = 'draw_text_centered', args = {text, font, x, y, r, sx, sy, ox, oy, color}, z = z or 0})
end

function graphics.draw_to_canvas(canvas, action)
  love.graphics.setCanvas{canvas, stencil=true}
  love.graphics.clear()
  action()
  love.graphics.setCanvas()
end

function layer:draw_to_canvas(canvas, action)
  table.insert(self.draw_commands, {type = 'draw_to_canvas', args = {canvas, action}, z = z or 0})
end

function graphics.ex(x, y, w, color, line_width)
  local r, g, b, a = love.graphics.getColor()
  if color then love.graphics.setColor(color.r, color.g, color.b, color.a) end
  if line_width then love.graphics.setLineWidth(line_width) end
  love.graphics.line(x - w/2, y - w/2, x + w/2, y + w/2)
  love.graphics.line(x - w/2, y + w/2, x + w/2, y - w/2)
  love.graphics.setColor(r, g, b, a)
  love.graphics.setLineWidth(1)
end

function layer:ex(x, y, w, color, line_width, z)
  table.insert(self.draw_commands, {type = 'ex', args = {x, y, w, color, line_width}, z = z or 0})
end

-- Draws a line with the given points.
function graphics.line(x1, y1, x2, y2, color, line_width)
  local r, g, b, a = love.graphics.getColor()
  if color then love.graphics.setColor(color.r, color.g, color.b, color.a) end
  if line_width then love.graphics.setLineWidth(line_width) end
  love.graphics.line(x1, y1, x2, y2)
  love.graphics.setColor(r, g, b, a)
  love.graphics.setLineWidth(1)
end

function layer:line(x1, y1, x2, y2, color, line_width, z)
  table.insert(self.draw_commands, {type = 'line', args = {x1, y1, x2, y2, color, line_width}, z = z or 0})
end

-- Draws a polygon with the given points.
-- If color is passed in then the polygon will be filled with that color (color is Color object)
-- If line_width is passed in then the polygon will not be filled and will instead be drawn as a set of lines of the given width.
function graphics.polygon(vertices, color, line_width)
  graphics.shape("polygon", color, line_width, vertices)
end

function layer:polygon(vertices, color, line_width, z)
  table.insert(self.draw_commands, {type = 'polygon', args = {vertices, color, line_width}, z = z or 0})
end

-- Draws a series of connected lines with the given points.
function graphics.polyline(vertices, color, line_width) 
  local r, g, b, a = love.graphics.getColor()
  if color then love.graphics.setColor(color.r, color.g, color.b, color.a) end
  if line_width then love.graphics.setLineWidth(line_width) end
  love.graphics.line(unpack(vertices))
  love.graphics.setColor(r, g, b, a)
  love.graphics.setLineWidth(1)
end

function layer:polyline(vertices, color, line_width, z)
  table.insert(self.draw_commands, {type = 'polyline', args = {vertices, color, line_width}, z = z or 0})
end

function graphics.pop()
  love.graphics.pop()
end

function layer:pop(z)
  table.insert(self.draw_commands, {type = 'pop', args = {}, z = z or 0})
end

function graphics.push(x, y, r, sx, sy)
  love.graphics.push()
  love.graphics.translate(x or 0, y or 0)
  love.graphics.scale(sx or 1, sy or sx or 1)
  love.graphics.rotate(r or 0)
  love.graphics.translate(-x or 0, -y or 0)
end

function layer:push(x, y, r, sx, sy, z)
  table.insert(self.draw_commands, {type = 'push', args = {x or 0, y or 0, r or 0, sx or 1, sy or sx or 1}, z = z or 0})
end

-- Draws a rectangle of size w, h centered on x, y.
-- If rx, ry are passed in, then the rectangle will have rounded corners with radius of that size.
-- If color is passed in then the rectangle will be filled with that color (color is Color object)
-- If line_width is passed in then the rectangle will not be filled and will instead be drawn as a set of lines of the given width.
function graphics.rectangle(x, y, w, h, rx, ry, color, line_width)
  graphics.shape("rectangle", color, line_width, x - w/2, y - h/2, w, h, rx, ry)
end

function layer:rectangle(x, y, w, h, rx, ry, color, line_width, z)
  table.insert(self.draw_commands, {type = 'rectangle', args = {x, y, w, h, rx, ry, color, line_width}, z = z or 0})
end

-- Draws a rectangle of size w, h centered on x - w/2, y - h/2.
-- If rx, ry are passed in, then the rectangle will have rounded corners with radius of that size.
-- If color is passed in then the rectangle will be filled with that color (color is Color object)
-- If line_width is passed in then the rectangle will not be filled and will instead be drawn as a set of lines of the given width.
function graphics.rectangle_lt(x, y, w, h, rx, ry, color, line_width)
  graphics.shape("rectangle", color, line_width, x, y, w, h, rx, ry)
end

function layer:rectangle_lt(x, y, w, h, rx, ry, color, line_width, z)
  table.insert(self.draw_commands, {type = 'rectangle_lt', args = {x, y, w, h, rx, ry, color, line_width}, z = z or 0})
end

function graphics.rotate(r)
  love.graphics.rotate(r)
end

function layer:rotate(r, z)
  table.insert(self.draw_commands, {type = 'rotate', args = {r or 0}, z = z or 0})
end

function graphics.scale(sx, sy)
  love.graphics.scale(sx, sy)
end

function layer:scale(sx, sy, z)
  table.insert(self.draw_commands, {type = 'scale', args = {sx or 1, sy or sx or 1}, z = z or 0})
end

function graphics.set_blend_mode(mode, alpha_mode)
  love.graphics.setBlendMode(mode, alpha_mode)
end

function layer:set_blend_mode(mode, alpha_mode, z)
  table.insert(self.draw_commands, {type = 'set_blend_mode', args = {mode or 'alpha', alpha_mode or 'alphamultiply'}, z = z or 0})
end

function graphics.set_color(color)
  love.graphics.setColor(color.r, color.g, color.b, color.a)
end

function layer:set_color(color, z)
  table.insert(self.draw_commands, {type = 'set_color', args = {color}, z = z or 0})
end

function graphics.set_color_rgba(r, g, b, a)
  love.graphics.setColor(r, g, b, a)
end

function layer:set_color_rgba(r, g, b, a, z)
  table.insert(self.draw_commands, {type = 'set_color_rgba', args = {r, g, b, a}, z = z or 0})
end

function graphics.set_shader(shader)
  if not shader then love.graphics.setShader()
  else love.graphics.setShader(shader) end
end

function layer:set_shader(shader, z)
  table.insert(self.draw_commands, {type = 'set_shader', args = {shader}, z = z or 0})
end

function graphics.shape(shape, color, line_width, ...)
  local r, g, b, a = love.graphics.getColor()
  if not color and not line_width then love.graphics[shape]("line", ...)
  elseif color and not line_width then
    love.graphics.setColor(color.r, color.g, color.b, color.a)
    love.graphics[shape]("fill", ...)
  else
    if color then love.graphics.setColor(color.r, color.g, color.b, color.a) end
    love.graphics.setLineWidth(line_width)
    love.graphics[shape]("line", ...)
    love.graphics.setLineWidth(1)
  end
  love.graphics.setColor(r, g, b, a)
end

function graphics.translate(x, y)
  love.graphics.translate(x, y)
end

function layer:translate(x, y, z)
  table.insert(self.draw_commands, {type = 'translate', args = {x or 0, y or 0}, z = z or 0})
end

function graphics.triangle(x, y, w, color, line_width)
  local h = math.sqrt(math.pow(w, 2) - math.pow(w/2, 2))
  local x1, y1 = x + h/2, y
  local x2, y2 = x - h/2, y - w/2
  local x3, y3 = x - h/2, y + w/2
  graphics.shape("polygon", color, line_width, {x1, y1, x2, y2, x3, y3})
end

function layer:triangle(x, y, w, color, line_width, z)
  table.insert(self.draw_commands, {type = 'triangle', args = {x, y, w, color, line_width}, z = z or 0})
end

return layer
