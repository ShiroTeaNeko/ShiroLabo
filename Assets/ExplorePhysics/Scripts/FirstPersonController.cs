using System;
using Unity.VisualScripting;
using UnityEngine;
using Random = UnityEngine.Random;

public class FirstPersonController : MonoBehaviour
{
    [Header("Movement Speeds")]
    [SerializeField] private float walkSpeed = 3.0f;
    [SerializeField] private float sprintMultiplier = 1.3f;
    
    [Header("Jump Parameters")]
    [SerializeField] private float jumpForce = 3.0f;
    [SerializeField] private float gravity = 9.81f;
    
    [Header("Look Sensitivity")]
    [SerializeField] private float mouseSensitivity = 2.0f;
    [SerializeField] private float upDownRange = 80.0f;
    
    [Header("Inputs Customisations")]
    [SerializeField] private string horizontalMoveInput = "Horizontal";
    [SerializeField] private string verticalMoveInput = "Vertical";
    [SerializeField] private string mouseXInput = "Mouse X";
    [SerializeField] private string mouseYInput = "Mouse Y";
    [SerializeField] private KeyCode sprintKey =  KeyCode.LeftShift;
    [SerializeField] private bool isSprinting = false;
    [SerializeField] private KeyCode jumpKey =  KeyCode.Space;
    [SerializeField] private KeyCode crouchKey =  KeyCode.LeftControl;
    [SerializeField] private bool isCrouching = false;
    [SerializeField] private bool isSliding = false;
    [SerializeField] private float slideSpeed = 12f;
    private Vector3 slideVelocity;
    [SerializeField] private float slideDeceleration = 8f;
    [SerializeField] private float minSlideSpeed = 2f;
    
    [Header("Footstep Sounds")]
    [SerializeField] private AudioSource footstepSource;
    [SerializeField] private AudioClip[] footstepSounds;
    [SerializeField] private float walkStepIntervals = .5f;
    [SerializeField] private float sprintStepIntervals = .3f;
    [SerializeField] private float velocitythreshold = 2.0f;
    
    
    [Header("Tools")]
    [SerializeField] private KeyCode actionKey = KeyCode.Mouse0;
    [SerializeField] private KeyCode inspectKey = KeyCode.F;
    [SerializeField] private Animator handAnimator;
    [SerializeField] private Tool equippedTool;
    [SerializeField] private Animator allPurposeAnimator;
    [SerializeField] private GameObject fakePickaxeInspect;

    [Header("Camera Settings")]
    private Camera _mainCamera;
    [SerializeField] private float baseCameraFov = 70.0f;
    [SerializeField] private float targetCameraFov = 80.0f;
    
    
    
    private int _lastPlayedIndex = -1;
    private bool _isMoving;
    private float _nextStepTime;
    private float _verticalRotation;
    private Vector3 _currentMovement = Vector3.zero;
    private CharacterController _characterController;

    private void Start()
    {
        _characterController = GetComponent<CharacterController>();
        _mainCamera = Camera.main;
        Cursor.lockState = CursorLockMode.Locked;
        Cursor.visible = false;
    }

    private void Update()
    {
        HandleFootsteps();
        HandleTool();
        HandleCameraSettings();
        HandleCrouchAndSlide();
    }

    private void LateUpdate()
    {
        HandleMovement();
        HandleRotation();
    }

    void HandleMovement()
    {
        float verticalInput = Input.GetAxis(verticalMoveInput);
        float horizontalInput = Input.GetAxis(horizontalMoveInput);
        float speedMultiplier = isSprinting ? sprintMultiplier : 1.0f;
        float verticalSpeed = verticalInput * walkSpeed * speedMultiplier;
        float horizontalSpeed = horizontalInput * walkSpeed * speedMultiplier;
        
        Vector3 horizontalMovement = new Vector3(horizontalSpeed, 0, verticalSpeed);
        horizontalMovement = transform.rotation * horizontalMovement;
        
        HandleGravityAndJumping();

        if (isSliding)
        {
            _currentMovement.x = slideVelocity.x;
            _currentMovement.z = slideVelocity.z;
            
            slideVelocity = Vector3.MoveTowards(slideVelocity, Vector3.zero, slideDeceleration * Time.deltaTime);

            if (slideVelocity.magnitude <= minSlideSpeed)
            {
                StopSlide();
            }
        }
        else
        {
            _currentMovement.x = horizontalMovement.x;
            _currentMovement.z = horizontalMovement.z;
        }
        
        _characterController.Move(_currentMovement * Time.deltaTime);
        _isMoving = verticalInput != 0 || horizontalInput != 0;
        
        if (Input.GetKeyDown(sprintKey))
        {
            isSprinting = !isSprinting;
        }

        if (verticalInput <= 0)
        {
            isSprinting = false;
        }
    }

    void HandleGravityAndJumping()
    {
        if (_characterController.isGrounded)
        {
            _currentMovement.y = -.5f;

            if (Input.GetKey(jumpKey))
            {
                _currentMovement.y = jumpForce;
            }
        }
        else
        {
            _currentMovement.y -= gravity * Time.deltaTime;
        }
    }

    void HandleRotation()
    {
        float mouseXRotation = Input.GetAxis(mouseXInput) * mouseSensitivity;
        transform.Rotate(0, mouseXRotation, 0);
        
        _verticalRotation -= Input.GetAxis(mouseYInput) * mouseSensitivity;
        _verticalRotation = Mathf.Clamp(_verticalRotation, -upDownRange, upDownRange);
        _mainCamera.transform.localRotation = Quaternion.Euler(_verticalRotation, 0, 0);
    }

    void HandleFootsteps()
    {
        float currentStepInterval = isSprinting ? sprintStepIntervals : walkStepIntervals;

        if (_characterController.isGrounded && _isMoving && Time.time > _nextStepTime && _characterController.velocity.magnitude > velocitythreshold)
        {
            FootstepSounds();
            _nextStepTime = Time.time + currentStepInterval;
        }
    }

    void FootstepSounds()
    {
        int randomIndex;
        if (footstepSounds.Length == 1)
        {
            randomIndex = 0;
        }
        else
        {
            randomIndex = Random.Range(0, footstepSounds.Length - 1);
            if (randomIndex >= _lastPlayedIndex)
            {
                randomIndex++;
            }
        }
        
        _lastPlayedIndex = randomIndex;
        footstepSource.clip = footstepSounds[randomIndex];
        footstepSource.Play();
    }

    void HandleTool()
    {
        if (Input.GetMouseButton(0))
        {
            ResetAndGoBackToTheTool();
            equippedTool.Attack();
        }

        if (Input.GetMouseButtonUp(0))
        {
            equippedTool.StopAttack();
        }

        if (Input.GetKeyDown(inspectKey))
        {
            equippedTool.animator.Rebind();
            allPurposeAnimator.enabled = true;
            allPurposeAnimator.SetTrigger("InspectPickaxe");
            fakePickaxeInspect.SetActive(true);
            equippedTool.gameObject.SetActive(false);
        }
    }

    public void ResetAndGoBackToTheTool()
    {
        allPurposeAnimator.ResetTrigger("InspectPickaxe");
        allPurposeAnimator.Rebind();
        allPurposeAnimator.enabled = false;
        equippedTool.gameObject.SetActive(true);
        fakePickaxeInspect.SetActive(false);
    }

    private bool rememberToSlide = false;
    void HandleCrouchAndSlide()
    {
        if (!_characterController.isGrounded && Input.GetKeyDown(crouchKey))
        {
            rememberToSlide = true;
        }
        else if (_characterController.isGrounded && rememberToSlide)
        {
            StartSlide();
            
            rememberToSlide = false;
        }
        
        if (Input.GetKeyDown(crouchKey))
        {
            if (isSprinting && _characterController.isGrounded)
            {
                StartSlide();
            }
            else
            {
                StartCrouch();
            }
        }

        if (Input.GetKeyUp(crouchKey))
        {
            if (isSliding)
            {
                StopSlide();
            }
            else if (isCrouching)
            {
                StopCrouch();
            }
        }
    }
    
    void StartCrouch()
    {
        isCrouching = true;

        // Lower CharacterController
        _characterController.height /= 2;
        // Lower camera
        //_mainCamera.transform.position = new Vector3(_mainCamera.transform.position.x, .25f, _mainCamera.transform.position.z);
    }

    void StopCrouch()
    {
        isCrouching = false;

        // Restore CharacterController
        _characterController.height *= 2;
        //_characterController.height = Mathf.Lerp(.5f, 1.0f, Time.deltaTime);
        // Restore camera
        //_mainCamera.transform.position = new Vector3(_mainCamera.transform.position.x, .5f, _mainCamera.transform.position.z);
    }

    void StartSlide()
    {
        isSliding = true;
        _characterController.height /= 2;
        
        slideVelocity = new Vector3(_currentMovement.x, 0, _currentMovement.z);

        slideVelocity *= 3f;
    }

    void StopSlide()
    {
        isSliding = false;
        // Restore CharacterController
        _characterController.height *= 2;

        slideVelocity = Vector3.Lerp(slideVelocity, Vector3.zero, slideSpeed * Time.deltaTime);
    }

    void HandleCameraSettings()
    {
        if (isSprinting)
        {
            _mainCamera.fieldOfView = Mathf.Lerp(_mainCamera.fieldOfView, targetCameraFov, Time.deltaTime);
        }
        else
        {
            _mainCamera.fieldOfView = Mathf.Lerp(_mainCamera.fieldOfView, baseCameraFov, Time.deltaTime * 3);
        }
    }
}
