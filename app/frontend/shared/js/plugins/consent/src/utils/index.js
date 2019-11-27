"use strict"

import * as cookie from "./cookie"
export const getCookie = cookie.getCookie
export const setCookie = cookie.setCookie


export const interpolateString = ( str, callback ) =>
  str.replace( /{{([a-z][a-z0-9\-_]*)}}/gi , ( matches, replaced ) => callback( replaced ) || '')

// only used for throttling the 'mousemove' event (used for animating the revoke button when `animateRevokable` is true)
export const throttle = (callback, limit) => {
  let wait = false
  return function() {
    if (!wait) {
      callback(...arguments)
      wait = true
      setTimeout(function() {
        wait = false
      }, limit)
    }
  }
}

// only used for hashing json objects (used for hash mapping palette objects, used when custom colours are passed through JavaScript)
export const hash = str => {
  let hashNum = 0,
    i = 0,
    chr,
    len = str.length
  if (str.length === 0) return hashNum
  for ( i; i < len; ++i ) {
    chr = str.charCodeAt( i )
    hashNum = ( hashNum << 5 ) - hashNum + chr
    hashNum |= 0
  }
  return hashNum
}
import * as style from "./style"
export const normalizeHex = style.normalizeHex
export const getContrast = style.getContrast
export const getLuminance = style.getLuminance
export const getHoverColor =style.getHoverColor

import * as dom from "./dom"
export const traverseDOMPath = dom.traverseDOMPath
export const addCustomStylesheet = dom.addCustomStylesheet

import * as validation from "./validation"
export const isValidStatus = validation.isValidStatus
export const isPlainObject = validation.isPlainObject
export const isMobile = validation.isMobile

import * as asyncFns from "./async"
export const getScript = asyncFns.getScript
export const makeAsyncRequest = asyncFns.makeAsyncRequest

const loopProperties = overwrites => (obj, [key, value]) => {
  if ( value instanceof Object && !(value instanceof Array) ) {
    if ( overwrites[ key ] instanceof Object && !(overwrites[ key ] instanceof Array)) {
      obj[ key ] = Object.entries(value).reduce(loopProperties(overwrites[key]), {})
    } else {
      obj[ key ] = value
    }
  } else {
    if ( overwrites.hasOwnProperty( key ) ) {
      obj[ key ] = overwrites[ key ]
    }else {
      obj[ key ] = value 
    }
  }
  return obj
}

export const mergeOptions = ( defaults, overwrites ) =>
  Object.entries(defaults).reduce(loopProperties(overwrites), {})
