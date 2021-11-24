class CanvasExample < Prism::Component
  include JS::Global

  EXPECTED_DELTA = 1000.0 / 60.0

  def initialize
    @time_elapsed = 0
    @delta = 0
    @keys = {}
    @canvas = document.createElement('canvas')
    @context = @canvas.getContext('2d')

    document.body.style.padding = '0';
    document.body.style.margin = '0';

    document.body.appendChild(@canvas)

    @x = 10
    @y = 10

    resize_canvas
    track_keyboard_events
    window.addEventListener('resize', method(:resize_canvas))

    window.requestAnimationFrame(method(:update))
  end

  def resize_canvas
    @canvas.width = window.innerWidth
    @canvas.height = window.innerHeight
  end

  def track_keyboard_events
    document.body.addEventListener('keydown') do |event|
      @keys[event.code] = true
    end

    document.body.addEventListener('keyup') do |event|
      @keys[event.code] = false
    end
  end

  def moving_right?
    @keys["KeyD"]
  end

  def moving_up?
    @keys["KeyW"]
  end

  def moving_down?
    @keys["KeyS"]
  end

  def moving_left?
    @keys["KeyA"]
  end

  def speed
    return 3 * @delta if @keys["ShiftLeft"]

    2 * @delta
  end

  def update(new_time_elapsed)
    @delta = (new_time_elapsed - @time_elapsed) / EXPECTED_DELTA
    @time_elapsed = new_time_elapsed

    step
    draw

    window.requestAnimationFrame(method(:update))
  end

  def step
    @x += speed if moving_right?
    @x -= speed if moving_left?
    @y -= speed if moving_up?
    @y += speed if moving_down?
  end

  def draw
    @context.fillStyle = 'white'
    @context.fillRect(0, 0, @canvas.width, @canvas.height)

    @context.clear

    @context.fillStyle = 'red'
    @context.fillRect(@x, @y, 20, 20)
  end

  def render
    div()
  end
end

Prism.mount(CanvasExample.new() {})
