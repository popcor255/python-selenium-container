#!/usr/bin/env python

from pyvirtualdisplay import Display
from selenium import webdriver

display = Display(visible=0, size=(800, 600))
display.start()

url = 'http://www.python.org'

print('browsing with chrome, ', url)
try:
  browser = webdriver.Chrome()
  browser.get(url)
  print(browser.title)
  browser.save_screenshot("test.png")
  browser.quit()
except Exception as e:
  print(e)

display.stop()
