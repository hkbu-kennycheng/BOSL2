include <constants.scad>
include <common.scad>

_BOSL2_AFFINE = is_undef(_BOSL2_STD) && (is_undef(BOSL2_NO_STD_WARNING) || !BOSL2_NO_STD_WARNING) ?
    echo("Warning: affine.scad included without std.scad; dependencies may be missing\nSet BOSL2_NO_STD_WARNING = true to mute this warning.") true : true;

// Section: Matrices

// Function: affine2d_identity()
// Topics: Affine, Matrices, Transforms
// See Also: affine3d_identity()
// Usage:
//   mat = affine2d_identity();
// Description:
//   Create a 2D affine identity matrix.
// Example:
//   mat = affine2d_identity();
//   // Returns:
//   //   [
//   //     [1, 0, 0],
//   //     [0, 1, 0],
//   //     [0, 0, 1]
//   //   ]
function affine2d_identity() =
    [
        [1, 0, 0],
        [0, 1, 0],
        [0, 0, 1]
    ];


// Function: affine3d_identity()
// Topics: Affine, Matrices, Transforms
// See Also: affine2d_identity()
// Usage:
//   mat = affine3d_identity();
// Description:
//   Create a 3D affine identity matrix.
// Example:
//   mat = affine3d_identity();
//   // Returns:
//   //   [
//   //     [1, 0, 0, 0],
//   //     [0, 1, 0, 0],
//   //     [0, 0, 1, 0],
//   //     [0, 0, 0, 1]
//   //   ]
function affine3d_identity() =
    [
        [1, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 1]
    ];



// Section: Translation

// Function: affine2d_translate()
// Topics: Affine, Matrices, Transforms, Translation
// See Also: move(), up(), down(), left(), right(), fwd(), back(), affine3d_translate()
// Usage:
//   mat = affine2d_translate(v);
// Description:
//   Returns the 3x3 affine 2D translation matrix for the given 2D movement vector.
// Arguments:
//   v = The 2D vector to get the translation matrix for.
// Example:
//   mat = affine2d_translate([30, 40]);
//   // Returns:
//   //   [
//   //     [1, 0, 30],
//   //     [0, 1, 40],
//   //     [0, 0,  1]
//   //   ]
function affine2d_translate(v) =
    assert(is_vector(v))
    let(v = point2d(v))
    [
        [1, 0, v.x],
        [0, 1, v.y],
        [0, 0,   1]
    ];


// Function: affine3d_translate()
// Topics: Affine, Matrices, Transforms, Translation
// See Also: move(), up(), down(), left(), right(), fwd(), back(), affine2d_translate()
// Usage:
//   mat = affine3d_translate(v);
// Description:
//   Returns the 4x4 affine 3D translation matrix for the given 3D movement vector.
// Arguments:
//   v = The 3D vector to get the translation matrix for.
// Example:
//   mat = affine3d_translate([30, 40, 50]);
//   // Returns:
//   //   [
//   //     [1, 0, 0, 30],
//   //     [0, 1, 0, 40],
//   //     [0, 0, 1, 50],
//   //     [0, 0, 0,  1]
//   //   ]
function affine3d_translate(v) =
    assert(is_vector(v))
    let(v = point3d(v))
    [
        [1, 0, 0, v.x],
        [0, 1, 0, v.y],
        [0, 0, 1, v.z],
        [0, 0, 0,   1]
    ];



// Section: Scaling

// Function: affine2d_scale()
// Topics: Affine, Matrices, Transforms, Scaling
// See Also: scale(), affine3d_scale()
// Usage:
//   mat = affine2d_scale(v);
// Description:
//   Returns the 3x3 affine 2D scaling matrix for the given 2D scaling vector.
// Arguments:
//   v = The 2D vector to get the scaling matrix for.
// Example:
//   mat = affine2d_scale([3, 4]);
//   // Returns:
//   //   [
//   //     [3, 0, 0],
//   //     [0, 4, 0],
//   //     [0, 0, 1]
//   //   ]
function affine2d_scale(v) =
    assert(is_num(v) || is_vector(v))
    let(v = is_num(v)? [v,v] : point2d(v,1))
    [
        [v.x,   0, 0],
        [  0, v.y, 0],
        [  0,   0, 1]
    ];


// Function: affine3d_scale()
// Topics: Affine, Matrices, Transforms, Scaling
// See Also: scale(), affine2d_scale()
// Usage:
//   mat = affine3d_scale(v);
// Description:
//   Returns the 4x4 affine 3D scaling matrix for the given 3D scaling vector.
// Arguments:
//   v = The 3D vector to get the scaling matrix for.
// Example:
//   mat = affine3d_scale([3, 4, 5]);
//   // Returns:
//   //   [
//   //     [3, 0, 0, 0],
//   //     [0, 4, 0, 0],
//   //     [0, 0, 5, 0],
//   //     [0, 0, 0, 1]
//   //   ]
function affine3d_scale(v) =
    assert(is_num(v) || is_vector(v))
    let(v = is_num(v)? [v,v,v] : point3d(v,1))
    [
        [v.x,   0,   0, 0],
        [  0, v.y,   0, 0],
        [  0,   0, v.z, 0],
        [  0,   0,   0, 1]
    ];



// Section: Rotation

// Function: affine2d_zrot()
// Topics: Affine, Matrices, Transforms, Rotation
// See Also: rot(), xrot(), yrot(), zrot(), affine3d_zrot()
// Usage:
//   mat = affine2d_zrot(ang);
// Description:
//   Returns the 3x3 affine 2D rotation matrix for the given rotation angle.
// Arguments:
//   ang = The angle in degrees to get the rotation matrix for.
// Example:
//   mat = affine2d_zrot(30);
//   // Returns:
//   //   [
//   //     [ 0.866025, -0.5, 0],
//   //     [ 0.5,       0.866025, 0],
//   //     [ 0,         0, 1]
//   //   ]
function affine2d_zrot(ang) =
    assert(is_num(ang))
    [
        [cos(ang), -sin(ang), 0],
        [sin(ang),  cos(ang), 0],
        [       0,         0, 1]
    ];


// Function: affine3d_xrot()
// Topics: Affine, Matrices, Transforms, Rotation
// See Also: rot(), xrot(), yrot(), zrot(), affine3d_yrot(), affine3d_zrot(), affine3d_rot_by_axis()
// Usage:
//   mat = affine3d_xrot(ang);
// Description:
//   Returns the 4x4 affine 3D rotation matrix for the given X-axis rotation angle.
// Arguments:
//   ang = The angle in degrees to get the rotation matrix for.
// Example:
//   mat = affine3d_xrot(30);
//   // Returns:
//   //   [
//   //     [1, 0,        0,       0],
//   //     [0, 0.866025, -0.5,    0],
//   //     [0, 0.5,      0.866025, 0],
//   //     [0, 0,        0,       1]
//   //   ]
function affine3d_xrot(ang) =
    assert(is_num(ang))
    [
        [1,        0,         0, 0],
        [0, cos(ang), -sin(ang), 0],
        [0, sin(ang),  cos(ang), 0],
        [0,        0,         0, 1]
    ];


// Function: affine3d_yrot()
// Topics: Affine, Matrices, Transforms, Rotation
// See Also: rot(), xrot(), yrot(), zrot(), affine3d_xrot(), affine3d_zrot(), affine3d_rot_by_axis()
// Usage:
//   mat = affine3d_yrot(ang);
// Description:
//   Returns the 4x4 affine 3D rotation matrix for the given Y-axis rotation angle.
// Arguments:
//   ang = The angle in degrees to get the rotation matrix for.
// Example:
//   mat = affine3d_yrot(30);
//   // Returns:
//   //   [
//   //     [ 0.866025, 0, 0.5,      0],
//   //     [ 0,        1, 0,        0],
//   //     [-0.5,      0, 0.866025, 0],
//   //     [ 0,        0, 0,        1]
//   //   ]
function affine3d_yrot(ang) =
    assert(is_num(ang))
    [
        [ cos(ang), 0, sin(ang), 0],
        [        0, 1,        0, 0],
        [-sin(ang), 0, cos(ang), 0],
        [        0, 0,        0, 1]
    ];


// Function: affine3d_zrot()
// Topics: Affine, Matrices, Transforms, Rotation
// See Also: rot(), xrot(), yrot(), zrot(), affine3d_xrot(), affine3d_yrot(), affine3d_rot_by_axis()
// Usage:
//   mat = affine3d_zrot(ang);
// Description:
//   Returns the 4x4 affine 3D rotation matrix for the given Z-axis rotation angle.
// Arguments:
//   ang = The angle in degrees to get the rotation matrix for.
// Example:
//   mat = affine3d_zrot(30);
//   // Returns:
//   //   [
//   //     [ 0.866025, -0.5,      0, 0],
//   //     [ 0.5,       0.866025, 0, 0],
//   //     [ 0,         0,        1, 0],
//   //     [ 0,         0,        0, 1]
//   //   ]
function affine3d_zrot(ang) =
    assert(is_num(ang))
    [
        [cos(ang), -sin(ang), 0, 0],
        [sin(ang),  cos(ang), 0, 0],
        [       0,         0, 1, 0],
        [       0,         0, 0, 1]
    ];


// Function: affine3d_rot_by_axis()
// Topics: Affine, Matrices, Transforms, Rotation
// See Also: rot(), xrot(), yrot(), zrot(), affine3d_xrot(), affine3d_yrot(), affine3d_zrot()
// Usage:
//   mat = affine3d_rot_by_axis(v, ang);
// Description:
//   Returns the 4x4 affine 3D rotation matrix for rotating around a 3D axis.
// Arguments:
//   v = The 3D axis vector to rotate around.
//   ang = The angle in degrees to rotate.
// Example:
//   mat = affine3d_rot_by_axis([1,1,1], 30);
//   // Returns:
//   //   [
//   //     [ 0.910684, -0.244017,  0.333333, 0],
//   //     [ 0.333333,  0.910684, -0.244017, 0],
//   //     [-0.244017,  0.333333,  0.910684, 0],
//   //     [ 0       ,  0       ,  0       , 1]
//   //   ]
function affine3d_rot_by_axis(v, ang) =
    assert(is_vector(v))
    assert(is_num(ang))
    let(
        v = unit(point3d(v)),
        c = cos(ang),
        c2 = 1-c,
        s = sin(ang)
    ) [
        [v.x*v.x*c2+c    , v.x*v.y*c2-v.z*s, v.x*v.z*c2+v.y*s, 0],
        [v.y*v.x*c2+v.z*s, v.y*v.y*c2+c    , v.y*v.z*c2-v.x*s, 0],
        [v.z*v.x*c2-v.y*s, v.z*v.y*c2+v.x*s, v.z*v.z*c2+c    , 0],
        [0               , 0               , 0               , 1]
    ];


function _fast_cardinal_matrix(v1, v2) =
    (v1 == UP && v2 == RIGHT) ? [[ 0, 0, 1, 0], [ 0, 1, 0, 0], [-1, 0, 0, 0], [ 0, 0, 0, 1]] :
    (v1 == UP && v2 == LEFT)  ? [[ 0, 0,-1, 0], [ 0, 1, 0, 0], [ 1, 0, 0, 0], [ 0, 0, 0, 1]] :
    (v1 == UP && v2 == FWD)   ? [[ 1, 0, 0, 0], [ 0, 0,-1, 0], [ 0, 1, 0, 0], [ 0, 0, 0, 1]] :
    (v1 == UP && v2 == BACK)  ? [[ 1, 0, 0, 0], [ 0, 0, 1, 0], [ 0,-1, 0, 0], [ 0, 0, 0, 1]] :
    (v1 == UP && v2 == DOWN)  ? [[ 1, 0, 0, 0], [ 0,-1, 0, 0], [ 0, 0,-1, 0], [ 0, 0, 0, 1]] :
    (v1 == v2)                ? [[ 1, 0, 0, 0], [ 0, 1, 0, 0], [ 0, 0, 1, 0], [ 0, 0, 0, 1]] :
    undef; // Fall through for arbitrary angles


// Function: affine3d_rot_from_to()
// Topics: Affine, Matrices, Transforms, Rotation
// See Also: rot(), xrot(), yrot(), zrot(), affine3d_xrot(), affine3d_yrot(), affine3d_zrot(), affine3d_rot_by_axis()
// Usage:
//   mat = affine3d_rot_from_to(from, to);
// Description:
//   Returns the 4x4 affine 3D rotation matrix to rotate the `from` vector to point in the direction of the `to` vector.
// Arguments:
//   from = The 3D vector to rotate from.
//   to = The 3D vector to rotate to.
// Example:
//   mat = affine3d_rot_from_to(UP, RIGHT);
//   // Returns:
//   //   [
//   //     [ 0, 0, 1, 0],
//   //     [ 0, 1, 0, 0],
//   //     [-1, 0, 0, 0],
//   //     [ 0, 0, 0, 1]
//   //   ]
function affine3d_rot_from_to(from, to) =
    assert(is_vector(from))
    assert(is_vector(to))
    let(
        from = unit(point3d(from)),
        to = unit(point3d(to)),
        fm = _fast_cardinal_matrix(from, to)
    )
    is_def(fm) ? fm : _rot_from_to_trig_fallback(from, to);

function _rot_from_to_trig_fallback(from, to) =
    let(
        axis = cross(from,to),
        ang = vector_angle(from,to)
    )
    affine3d_rot_by_axis(axis, ang);



// Section: Skewing

// Function: affine2d_skew()
// Topics: Affine, Matrices, Transforms, Skewing
// See Also: skew(), affine3d_skew()
// Usage:
//   mat = affine2d_skew(xa, ya);
// Description:
//   Returns the 3x3 affine 2D skew matrix for the given X and Y axis skew angles.
// Arguments:
//   xa = Skew angle, in degrees, in the direction of the X axis.
//   ya = Skew angle, in degrees, in the direction of the Y axis.
// Example:
//   mat = affine2d_skew(xa=15, ya=-15);
//   // Returns:
//   //   [
//   //     [ 1,       -0.267949, 0],
//   //     [ 0.267949, 1,        0],
//   //     [ 0,        0,        1]
//   //   ]
function affine2d_skew(xa=0, ya=0) =
    assert(is_num(xa))
    assert(is_num(ya))
    [
        [1,       tan(xa), 0],
        [tan(ya), 1,       0],
        [0,       0,       1]
    ];


// Function: affine3d_skew()
// Topics: Affine, Matrices, Transforms, Skewing
// See Also: skew(), affine2d_skew()
// Usage:
//   mat = affine3d_skew([sxy, sxz, syx, syz, szx, szy]);
// Description:
//   Returns the 4x4 affine 3D skew matrix for the given skew angles.
// Arguments:
//   sxy = Skew angle of X along the Y axis.
//   sxz = Skew angle of X along the Z axis.
//   syx = Skew angle of Y along the X axis.
//   syz = Skew angle of Y along the Z axis.
//   szx = Skew angle of Z along the X axis.
//   szy = Skew angle of Z along the Y axis.
// Example:
//   mat = affine3d_skew(sxy=15, szx=-15);
//   // Returns:
//   //   [
//   //     [ 1,        0.267949, 0,        0],
//   //     [ 0,        1,        0,        0],
//   //     [-0.267949, 0,        1,        0],
//   //     [ 0,        0,        0,        1]
//   //   ]
function affine3d_skew(sxy=0, sxz=0, syx=0, syz=0, szx=0, szy=0) =
    assert(is_num(sxy))
    assert(is_num(sxz))
    assert(is_num(syx))
    assert(is_num(syz))
    assert(is_num(szx))
    assert(is_num(szy))
    [
        [       1, tan(sxy), tan(sxz), 0],
        [tan(syx),        1, tan(syz), 0],
        [tan(szx), tan(szy),        1, 0],
        [       0,        0,        0, 1]
    ];


// vim: expandtab tabstop=4 shiftwidth=4 softtabstop=4 nowrap