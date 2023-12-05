package raylib

when ODIN_OS == .Windows {
	foreign import lib {"windows/raylib.lib", "system:Winmm.lib", "system:Gdi32.lib", "system:User32.lib", "system:Shell32.lib"}
} else when ODIN_OS == .Linux {
	foreign import lib "linux/libraylib.a"
} else when ODIN_OS == .Darwin {
	when ODIN_ARCH == .arm64 {
		foreign import lib {"macos-arm64/libraylib.a", "system:Cocoa.framework", "system:OpenGL.framework", "system:IOKit.framework"}
	} else {
		foreign import lib {"macos/libraylib.a", "system:Cocoa.framework", "system:OpenGL.framework", "system:IOKit.framework"}
	}
} else {
	foreign import lib "system:raylib"
}

@(default_calling_convention = "c")
foreign lib {
	// Returns the cameras forward vector (normalized)
	GetCameraForward :: proc(camera: ^Camera3D) -> Vector3 ---
	// Returns the cameras up vector (normalized)
	// Note: The up vector might not be perpendicular to the forward vector
	GetCameraUp :: proc(camera: ^Camera3D) -> Vector3 ---
	// Returns the cameras right vector (normalized)
	GetCameraRight :: proc(camera: ^Camera3D) -> Vector3 ---

	// Camera movement
	// Moves the camera in its forward direction
	CameraMoveForward :: proc(camera: ^Camera3D, distance: f32, moveInWorldPlane: bool) ---
	// Moves the camera in its up direction
	CameraMoveUp :: proc(camera: ^Camera3D, distance: f32) ---
	// Moves the camera target in its current right direction
	CameraMoveRight :: proc(camera: ^Camera3D, distance: f32, moveInWorldPlane: bool) ---
	// Moves the camera position closer/farther to/from the camera target
	CameraMoveToTarget :: proc(camera: ^Camera3D, delta: f32) ---

	// Camera rotation
	// Rotates the camera around its up vector
	// Yaw is "looking left and right"
	// If rotateAroundTarget is false, the camera rotates around its position
	// Note: angle must be provided in radians
	CameraYaw :: proc(camera: ^Camera3D, angle: f32, rotateAroundTarget: bool) ---
	// Rotates the camera around its right vector, pitch is "looking up and down"
	//  - lockView prevents camera overrotation (aka "somersaults")
	//  - rotateAroundTarget defines if rotation is around target or around its position
	//  - rotateUp rotates the up direction as well (typically only usefull in CAMERA_FREE)
	// NOTE: angle must be provided in radians
	CameraPitch :: proc(camera: ^Camera3D, angle: f32, lockView: bool, rotateAroundTarget: bool, rotateUp: bool) ---
	// Rotates the camera around its forward vector
	// Roll is "turning your head sideways to the left or right"
	// Note: angle must be provided in radians
	CameraRoll :: proc(camera: ^Camera3D, angle: f32) ---

	// Returns the camera view matrix
	GetCameraViewMatrix :: proc(camera: ^Camera3D) -> Matrix ---
	// Returns the camera projection matrix
	GetCameraProjectionMatrix :: proc(camera: ^Camera3D, aspect: f32) -> Matrix ---
}
