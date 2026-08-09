require_relative 'trig_sine'
require_relative 'trig_cosine'
require_relative 'trig_tangent'
require_relative 'trig_arctan'
require_relative 'hyp_sinh'
require_relative 'hyp_cosh'
require_relative 'hyp_tanh'
require_relative 'log_natural'
require_relative 'log_common'
require_relative 'log_binary'
require_relative 'pow_sqrt'
require_relative 'pow_cbrt'
require_relative 'pow_square'
require_relative 'pow_cube'
require_relative 'pow_exp'
require_relative 'round_floor'
require_relative 'round_ceil'
require_relative 'round_nearest'
require_relative 'round_trunc'
require_relative 'num_absolute'
require_relative 'num_sign'
require_relative 'conv_radians'
require_relative 'conv_degrees'
require_relative 'conv_celsius'
require_relative 'conv_fahrenheit'
require_relative 'bi_arctangent'
require_relative 'bi_remainder'
require_relative 'bi_maximum'
require_relative 'bi_minimum'
require_relative 'bi_hypotenuse'

def full_table
  {
    "trig_sine" => method(:trig_sine),
    "trig_cosine" => method(:trig_cosine),
    "trig_tangent" => method(:trig_tangent),
    "trig_arctan" => method(:trig_arctan),
    "hyp_sinh" => method(:hyp_sinh),
    "hyp_cosh" => method(:hyp_cosh),
    "hyp_tanh" => method(:hyp_tanh),
    "log_natural" => method(:log_natural),
    "log_common" => method(:log_common),
    "log_binary" => method(:log_binary),
    "pow_sqrt" => method(:pow_sqrt),
    "pow_cbrt" => method(:pow_cbrt),
    "pow_square" => method(:pow_square),
    "pow_cube" => method(:pow_cube),
    "pow_exp" => method(:pow_exp),
    "round_floor" => method(:round_floor),
    "round_ceil" => method(:round_ceil),
    "round_nearest" => method(:round_nearest),
    "round_trunc" => method(:round_trunc),
    "num_absolute" => method(:num_absolute),
    "num_sign" => method(:num_sign),
    "conv_radians" => method(:conv_radians),
    "conv_degrees" => method(:conv_degrees),
    "conv_celsius" => method(:conv_celsius),
    "conv_fahrenheit" => method(:conv_fahrenheit),
    "bi_arctangent" => method(:bi_arctangent),
    "bi_remainder" => method(:bi_remainder),
    "bi_maximum" => method(:bi_maximum),
    "bi_minimum" => method(:bi_minimum),
    "bi_hypotenuse" => method(:bi_hypotenuse),
  }
end

def apply_named(name, args)
  fn = full_table[name]
  fn.call(*args)
end
