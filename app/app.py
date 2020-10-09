#!/usr/bin/env python

from pyvirtualdisplay import Display
from selenium import webdriver

display = Display(visible=0, size=(800, 600))
display.start()

chrome_options = webdriver.ChromeOptions()
chrome_options.add_argument('--headless')
chrome_options.add_argument('--no-sandbox')
chrome_options.add_argument('--disable-dev-shm-usage')
chrome_options.add_argument("--disable-setuid-sandbox")

url = 'http://www.python.org'

print('browsing with chrome, ', url)
try:
  browser = webdriver.Chrome(options=chrome_options)
  browser.get(url)
  print(browser.title)
  browser.save_screenshot("test.png")
  browser.quit()
except Exception as e:
  print(e)

display.stop()
