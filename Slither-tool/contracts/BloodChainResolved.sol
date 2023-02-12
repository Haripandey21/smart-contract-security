// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract BloodSupply  {
    constructor() {
        owner = msg.sender;
    }
 address public owner;
    uint256 internal supplierId;
    uint256 internal hospitalId;
    address[] public suppliers;
    address[] public hospitals;
    uint256[] internal patients;
    uint256 internal bloodUniqueId;

    struct Donor {
        string donorName;
        uint256 age;
        string gender;
        string Address;
        string bloodGroup;
        uint256 bloodVolume;
        uint256 bloodUniqueId;
        uint256 donatedTime;
    }
    struct BloodDetails{
        uint256 bloodUniqueId;
        string bloodGroup;
        uint256 donatedTime;
        Status currentStatus;
    }

    struct Supplier {
        address supplierAddress;
        string organizationName;
        uint256 phoneNumber;
        uint256 addedTime;
    }

    struct Hospital {
        address hospitalAddress;
        string hospital_name;
        uint256 phoneNumber;
        uint256 addedTime;
    }

    struct Patient {
        string patientName;
        uint256 age;
        string Address;
        string bloodGroup;
        uint256 usedBloodId;
        uint256 usedTime;
        
    }

    mapping(uint256 => Supplier) internal mappedSupplier;
    mapping(uint256 => Hospital) internal mappedHospital;
    mapping(uint256 => Donor) internal mappedDonor;
    mapping(uint256 => Patient) internal mappedPatient;
    mapping(uint256 => BloodDetails) internal mappedBloodDetails;

   // mappings to check suppliers,hospitals in modifiers, so not to check by loops
    mapping (address => bool) internal authorizedSuppliers;
    mapping (address => bool) internal authorizedHospitals;

enum Status {    
     pending,  // no record of blood, 
     Active,  // Donor donated his blood & yet to be shipped to Hospital 
     Shipped, // Blood shipped to Hospital * yet to be used by Patients
     Fulfilled // Blood Used by patient 
} 

  modifier checkOwner(address _owner) {
        require(_owner == owner, "you are not a Owner !!");
        _;
    }

   modifier checkSupplier(address _entity) {
    require(authorizedSuppliers[_entity], "You are not a Authorized Supplier !!");
    _;
}

   modifier checkHospital(address _entity) {
    require(authorizedHospitals[_entity], "You are not a Authorized Hospital !!");
    _;
}

   modifier existsHospitalPermission(address _addresss) {
    require(authorizedHospitals[_addresss],  "No permision to Ship Blood Here !!");
    _;
} 
    event EventSupplierAdded(
        address supplier,
        string organizationName,
        uint256 phoneNumber,
        uint256 addedTime
    );
    event EventHospitalAdded(
        address hospital,
        string hospital_name,
        uint256 phoneNumber,
        uint256 addedTime
    );
    event EventBloodShipped(
        address supplierAddress,
        uint256 blood_id,
        address hospitalAddress,
        uint256 shipping_time
    );

    // ------------------------    Functions for Owner    -----------------------
    function addSupplier(
        address _bloodGroup,
        string memory _organizationName,
        uint256 _phoneNumber
    ) public checkOwner(msg.sender) {
        mappedSupplier[supplierId] = Supplier(
            _bloodGroup,
            _organizationName,
            _phoneNumber,
            block.timestamp
        );
        authorizedSuppliers[_bloodGroup]=true;
        suppliers.push(_bloodGroup);
        supplierId++;
        emit EventSupplierAdded(
            _bloodGroup,
            _organizationName,
            _phoneNumber,
            block.timestamp
        );
    }

    function addHospital(
        address _hospitalAddress,
        string memory _hospitalName,
        uint256 _phoneNumber
    ) public checkOwner(msg.sender) {
        mappedHospital[hospitalId] = Hospital(
            _hospitalAddress,
            _hospitalName,
            _phoneNumber,
            block.timestamp
        );
        authorizedHospitals[_hospitalAddress]=true;
        hospitals.push(_hospitalAddress);
        hospitalId++;
        emit EventHospitalAdded(
            _hospitalAddress,
            _hospitalName,
            _phoneNumber,
            block.timestamp
        );
    }

    //--------------------     Functions for Suppliers   --------------
    function addBlood(
        string memory _donorName,
        uint256 _age,
        string memory _gender,
        string memory _Address,
        string memory _bloodGroup,
        uint256 _bloodVolume
    ) public checkSupplier(msg.sender) {
        mappedDonor[bloodUniqueId] = Donor(
            _donorName,
            _age,
            _gender,
            _Address,
            _bloodGroup,
            _bloodVolume,
            bloodUniqueId,
            block.timestamp
        );
        mappedBloodDetails[bloodUniqueId].currentStatus = Status.Active;
        bloodUniqueId++;
    }

    function shipBloodToHospital(
        uint _blood_id,
        address _hospitalAddress
    )
        public
        checkSupplier(msg.sender)
        existsHospitalPermission(_hospitalAddress)
    {
        mappedBloodDetails[_blood_id].currentStatus = Status.Shipped;
        emit EventBloodShipped(
            msg.sender,
            _blood_id,
            _hospitalAddress,
            block.timestamp
        );
    }

    //--------------------------------Function for Hospitals ------------

    function giveBloodToPatients(
        uint256 _blood_id,
        string memory _patientName,
        uint256 _age,
        string memory _address,
        string memory _bloodGroup,
        uint256 _usedTime
    ) public checkHospital(msg.sender) {
        mappedPatient[_blood_id] = Patient(
            _patientName,
            _age,
            _address,
            _bloodGroup,
            _blood_id,
            _usedTime
        );
        patients.push(_blood_id);
        mappedBloodDetails[_blood_id].currentStatus = Status.Fulfilled;
    }

    //----------------------------   Functions for Public  -------------
    function getDataOfSuppliers() external view returns (Supplier[] memory) {
        // new array of structure
        Supplier[] memory supplierData = new Supplier[](suppliers.length);
        for (uint256 i = 0; i < suppliers.length; i++) {
            Supplier memory newStructData = Supplier(
                mappedSupplier[i].supplierAddress,
                mappedSupplier[i].organizationName,
                mappedSupplier[i].phoneNumber,
                mappedSupplier[i].addedTime
            );
            supplierData[i] = newStructData;
        }
        return supplierData;
    }

    function getDataOfHospitals() external view returns (Hospital[] memory) {
        Hospital[] memory hospitalData = new Hospital[](hospitals.length);
        for (uint256 i = 0; i < hospitals.length; i++) {
            Hospital memory newStructData = Hospital(
                mappedHospital[i].hospitalAddress,
                mappedHospital[i].hospital_name,
                mappedHospital[i].phoneNumber,
                mappedHospital[i].addedTime
            );
            hospitalData[i] = newStructData;
        }
        return hospitalData;
    }

    function getDataOfBlood() external view returns (BloodDetails[] memory) {
        BloodDetails[] memory bloodData = new BloodDetails[](bloodUniqueId);
        for (uint256 i = 0; i < bloodUniqueId; i++) {
            BloodDetails memory newStructData = BloodDetails(
                mappedDonor[i].bloodUniqueId,
                mappedDonor[i].bloodGroup,
                mappedDonor[i].donatedTime,
                mappedBloodDetails[i].currentStatus
            );
            bloodData[i] = newStructData;
        }
        return bloodData;
    }

    function getBloodStatus(uint256 _id) external view returns (string memory) {
        return
            (mappedBloodDetails[_id].currentStatus == Status.Active)
                ? "Active"
                : (mappedBloodDetails[_id].currentStatus == Status.Shipped)
                ? "Shipped"
                : (mappedBloodDetails[_id].currentStatus == Status.Fulfilled)
                ? "Fulfilled"
                : "No record of that Blood_id";
    }

    // function only for owner
    function getDataOfDonors()
        external
        view
        checkOwner(msg.sender)
        returns (Donor[] memory)
    {
        Donor[] memory donorData = new Donor[](bloodUniqueId);
        for (uint256 i = 0; i < bloodUniqueId; i++) {
            Donor memory newStructData = Donor(
                mappedDonor[i].donorName,
                mappedDonor[i].age,
                mappedDonor[i].gender,
                mappedDonor[i].Address,
                mappedDonor[i].bloodGroup,
                mappedDonor[i].bloodVolume,
                mappedDonor[i].bloodUniqueId,
                mappedDonor[i].donatedTime
            );
            donorData[i] = newStructData;
        }
        return donorData;
    }

    function getDataOfPatients()
        external
        view
        checkOwner(msg.sender)
        returns (Patient[] memory)
    {
        Patient[] memory patientData = new Patient[](bloodUniqueId);
        for (uint256 i = 0; i < patients.length; i++) {
            Patient memory newStructData = Patient(
                mappedPatient[i].patientName,
                mappedPatient[i].age,
                mappedPatient[i].Address,
                mappedPatient[i].bloodGroup,
                mappedPatient[i].usedBloodId,
                mappedPatient[i].usedTime
            );
            patientData[i] = newStructData;
        }
        return patientData;
    }
}