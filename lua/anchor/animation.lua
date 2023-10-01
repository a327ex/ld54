local animation = class:class_new()
function animation:animation_init(delay, animation_frames, loop_mode, actions)
  self.animation_frames = animation_frames
  self:animation_logic_init(delay, self.animation_frames.size, loop_mode, actions)
  self.w, self.h = self.animation_frames.frame_w, self.animation_frames.frame_h
  return self
end

function animation:animation_update(dt, layer, x, y, r, sx, sy, ox, oy, color, shader, z)
  self:animation_logic_update(dt)
  self.animation_frames:animation_frames_draw(layer, self.frame, x, y, r, sx, sy, ox, oy, color, shader, z)
end

return animation
