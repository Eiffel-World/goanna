/*
 * $Id$
 *
 * bit manipulation macros for ISE Eiffel 4
 *
 * See class BIT_MANIPULATION in utility/spec/ise4
 *
 */

#include "eif_cecil.h"

#define bit_shift_left(i, n)			((EIF_INTEGER) ((i) << (n)))
#define bit_shift_right(i, n)			((EIF_INTEGER) ((i) >> (n)))
#define bit_and(i, n)				((EIF_INTEGER) ((i) & (n)))
#define bit_or(i, n)				((EIF_INTEGER) ((i) | (n)))
