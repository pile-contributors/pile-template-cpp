/* ========================================================================= */
/* ------------------------------------------------------------------------- */
/*!
  \file         tempile-private.h
  \date         October 2014
  \author       TNick

  \brief        Contains private definitions


*//*

 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Please read COPYING and README files in root folder
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

*/
/* ------------------------------------------------------------------------- */
/* ========================================================================= */
#ifndef __TEMPILE_PRIVATE_INC__
#define __TEMPILE_PRIVATE_INC__
//
//
//
//
/*  INCLUDES    ------------------------------------------------------------ */

#include <tempile/tempile-config.h>

namespace tempile {

/*  INCLUDES    ============================================================ */
//
//
//
//
/*  DEFINITIONS    --------------------------------------------------------- */


#if 0
#define TEMPILE_DEBUGM printf
#else
#define TEMPILE_DEBUGM black_hole
#endif

#if 0
#define TEMPILE_TRACE_ENTRY printf("TEMPILE ENTRY %s in %s[%d]\n", __func__, __FILE__, __LINE__)
#else
#define TEMPILE_TRACE_ENTRY
#endif

#if 0
#define TEMPILE_TRACE_EXIT printf("TEMPILE EXIT %s in %s[%d]\n", __func__, __FILE__, __LINE__)
#else
#define TEMPILE_TRACE_EXIT
#endif

/*  DEFINITIONS    ========================================================= */
//
//
//
//
/*  DATA    ---------------------------------------------------------------- */


/*  DATA    ================================================================ */
//
//
//
//
/*  FUNCTIONS    ----------------------------------------------------------- */

static inline void black_hole (...)
{}

/*  FUNCTIONS    =========================================================== */
//
//
//
//

} // namespace tempile

#endif // __TEMPILE_PRIVATE_INC__
/* ------------------------------------------------------------------------- */
/* ========================================================================= */
