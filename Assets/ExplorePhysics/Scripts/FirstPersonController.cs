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
    [SerializeField] private KeyCode jumpKey =  KeyCode.Space;
    
    [Header("Footstep Sounds")]
    [SerializeField] private AudioSource footstepSource;
    [SerializeField] private AudioClip[] footstepSounds;
    [SerializeField] private float walkStepIntervals = .5f;
    [SerializeField] private float sprintStepIntervals = .3f;
    [SerializeField] private float velocitythreshold = 2.0f;
    
    
    [Header("Tools")]
    [SerializeField] private KeyCode actionKey = KeyCode.Mouse0;
    [SerializeField] private Animator handAnimator;

    private int _lastPlayedIndex = -1;
    private bool _isMoving;
    private float _nextStepTime;
    private Camera _mainCamera;
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
        HandleMovement();
        HandleRotation();
        HandleFootsteps();
        HandleMining();
    }

    void HandleMovement()
    {
        float verticalInput = Input.GetAxis(verticalMoveInput);
        float horizontalInput = Input.GetAxis(horizontalMoveInput);
        float speedMultiplier = Input.GetKey(sprintKey) ? sprintMultiplier : 1.0f;
        float verticalSpeed = verticalInput * walkSpeed * speedMultiplier;
        float horizontalSpeed = horizontalInput * walkSpeed * speedMultiplier;
        
        Vector3 horizontalMovement = new Vector3(horizontalSpeed, 0, verticalSpeed);
        horizontalMovement = transform.rotation * horizontalMovement;
        
        HandleGravityAndJumping();
        
        _currentMovement.x = horizontalMovement.x;
        _currentMovement.z = horizontalMovement.z;
        
        _characterController.Move(_currentMovement * Time.deltaTime);
        _isMoving = verticalInput != 0 || horizontalInput != 0;
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
        float currentStepInterval = Input.GetKey(sprintKey) ? sprintStepIntervals : walkStepIntervals;

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

    void HandleMining()
    {
        if (Input.GetMouseButton(0))
        {
            handAnimator.SetTrigger("DoAction");
        }
    }
}
