# Pimorini Pyhon modified successfully to run Fan only as fast as needed using a fixed PWM speed 

It does not make much difference how fast the fan is running as long as its putting enough colder air by the cpu it gets cooled about the same. (tests done using the  algorithm_test_cooling.py algoritmm in the pwm_fanshim branch of my [RPi4_Python_FanshimPWM_Temperature_Control_with_logging](https://github.com/grayerbeard/RPi4_Python_FanshimPWM_Temperature_Control_with_logging/tree/pwm_fanshim) repository. 70 to 75% speed is well fast enough and is much quieter.   

Althouigh the cooling effect is arount 30 to 40% less its actually enough to cool the CPU when running a 100% load stress test down to around 62 C.

## December 6th 1200hrs
(1) Modified __init__.py so that when command given to run fan it should run at 70% speed instead of 100%.   Extensive test have shown that the cooling effect is very similar at a slower speed and yet the fan is much quieter.  Then added a tmux_start.py command that can be usd to run in a tmux session.
(2) Installed and tests completed December 6th 1420hrs. Ran 100% stress test and cooling OK with fan running at 70% speed instead of 100%.  Temperatures used; On at 65 off at 60.  Will later install logging to check long term behaviour.


# Fan Shim for Raspberry Pi

[![Build Status](https://travis-ci.com/pimoroni/fanshim-python.svg?branch=master)](https://travis-ci.com/pimoroni/fanshim-python)
[![Coverage Status](https://coveralls.io/repos/github/pimoroni/fanshim-python/badge.svg?branch=master)](https://coveralls.io/github/pimoroni/fanshim-python?branch=master)
[![PyPi Package](https://img.shields.io/pypi/v/fanshim.svg)](https://pypi.python.org/pypi/fanshim)
[![Python Versions](https://img.shields.io/pypi/pyversions/fanshim.svg)](https://pypi.python.org/pypi/fanshim)

# Installing

Stable Pimorini version library from PyPi:

* Just run `sudo pip install fanshim`

Latest/development library from THE PIMORINI GitHub:

* `git clone https://github.com/pimoroni/fanshim-python`
* `cd fanshim-python`
* `sudo ./install.sh`

### My "Slower Speed Development" library from HERE using PWM to run fan slower:

#### Install and run automatic.py in a tmux session using my version of __init__.py
* `cd /home/pi`
* `git clone https://github.com/grayerbeard/fanshim-python.git`
* `cd /home/pi/fanshim-python`
* `sudo ./install.sh`
* `./tmux_start.sh`
### Notes
* If not installed install tmux with `sudo apt-get install tmux`
* To start automatically put this into `rc.local` using `sudo nano /etc/rc.local` : `sudo -u pi bash /home/pi/fanshim-python/tmux_start.sh &`
* To change parameters used edit `tmux_start.sh`.
* To check if tmux session running OK use `tmux ls`
* To observe program output use `tmux a -t fanshim_pwm`
* To leave tmux seession use `ctrl-b` `d`


# Reference for using commands in your own Python Program

You should first set up an instance of the `FANShim` class, eg:

```python
from fanshim import FanShim
fanshim = FanShim()
```

## Fan

Turn the fan on with:

```python
fanshim.set_fan(True)
```

Turn it off with:

```python
fanshim.set_fan(False)
```

You can also toggle the fan with:

```python
fanshim.toggle_fan()
```

You can check the status of the fan with:

```python
fanshim.get_fan() # returns 1 for 'on', 0 for 'off'
```

## LED

Fan Shim includes one RGB APA-102 LED.

Set it to any colour with:

```python
fanshim.set_light(r, g, b)
```

Arguments r, g and b should be numbers between 0 and 255 that describe the colour you want.

For example, full red:

```
fanshim.set_light(255, 0, 0)
```

## Button

Fan Shim includes a button, you can bind actions to press, release and hold events.

Do something when the button is pressed:

```python
@fanshim.on_press()
def button_pressed():
    print("The button has been pressed!")
```

Or when it has been released:

```python
@fanshim.on_release()
def button_released(was_held):
    print("The button has been pressed!")
```

Or when it's been pressed long enough to trigger a hold:

```python
fanshim.set_hold_time(2.0)

@fanshim.on_hold()
def button_held():
    print("The button was held for 2 seconds")
```

The function you bind to `on_release()` is passed a `was_held` parameter,
this lets you know if the button was held down for longer than the configured
hold time. If you want to bind an action to "press" and another to "hold" you
should check this flag and perform your action in the `on_release()` handler:

```python
@fanshim.on_release()
def button_released(was_held):
    if was_held:
        print("Long press!")
    else:
        print("Short press!")
```

To configure the amount of time the button should be held (in seconds), use:

```python
fanshim.set_hold_time(number_of_seconds)
```

If you need to stop Fan Shim from polling the button, use:

```python
fanshim.stop_polling()
```

You can start it again with:

```python
fanshim.start_polling()
```

