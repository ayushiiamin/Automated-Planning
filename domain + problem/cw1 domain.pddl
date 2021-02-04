(define (domain cw1)
    (:requirements
        :strips :typing :equality
    )

    (:types
        expMiniSub drillMiniSub - miniSub
        captain navigator scienceOfficer engineer security - personnel
        bridge sciLab launchBay sickBay - subSections 
        vortexReport mineralReport baseReport sensorReport fossilReport - report
        submarine
        underWaterRegion
        region
        vortex
        machine
        vortex
        mineral
        sensorNet
        baseUW
        atlanteans
        baseLeader
        robot
        seaPort
        portSystem
        fossil
        fossilDetector
        storage
    )

    (:predicates
        (location ?y ?z)
        (onBridge ?p - personnel ?b - bridge)
        (order ?c - captain ?n - navigator ?r - region)
        (travelTo ?n - navigator ?r - region)
        (contains ?u - underWaterRegion ?r - region)
        (containsVortex ?h ?v)
        (presentInSubSection ?p - personnel ?ss - subSections)
        (scan ?sci - scienceOfficer ?v - vortex)
        (orderV ?c - captain ?n - navigator ?v - vortex)
        (directTo ?n - navigator ?v - vortex)
        (activatedPressureShields ?e - engineer)
        (enterVortex ?s - submarine ?v - vortex)
        (moveTo ?n - navigator ?s - submarine ?u - underWaterRegion)
        (vortexScanComp ?v - vortex)
        (generateReport ?ma - machine ?re - report)
        (release ?ms - miniSub)
        (drill ?m - mineral)
        (onLaunchBay ?p - personnel ?lb - launchBay)
        (onLaunchBayMS ?ms - miniSub ?lb - launchBay)
        (operateLaunch ?e - engineer)
        (returnBack ?ms - miniSub)
        (presentInRidge ?m - mineral ?r - region)
        (collect ?sci - scienceOfficer ?m - mineral)
        (at ?p - personnel ?ss - subSections)
        (adjacent ?ss1 - subSections ?ss2 - subSections)
        (studyMinerals ?sci - scienceOfficer ?m - mineral)
        (sampleStudyComp ?m - mineral)
        (subAtVortexArea ?s - submarine ?v - vortex)
        (operateMS ?e - engineer ?ems - expMiniSub)
        (setUpDevice ?e - engineer ?sen - sensorNet)
        (deploy ?sen - sensorNet)
        (presentInMS ?p - personnel ?ms - miniSub)
        (robPresentIn ?ro - robot ?ss - subSections)
        (has ?r - region ?ba - baseUW)
        (takenOver ?at - atlanteans ?ba - baseUW)
        (injured ?c - captain)
        (meet ?c - captain ?bl - baseLeader)
        (returnBackSen ?ms - miniSub)
        (activateSen ?e - engineer ?sen - sensorNet)
        (admittedIn ?p - personnel ?sb - sickBay)
        (operateInjured ?ro - robot ?p - personnel)
        (healthy ?p - personnel)
        (statusPassed ?ba - baseUW)
        (statusUnderAttack ?ba - baseUW)
        (goBackSeaport ?s - submarine ?sp - seaPort)
        (placeFolder ?re - report)
        (atPortSystem ?re - report ?sys - portSystem)
        (fossilDetected ?f - fossil ?de - fossilDetector)
        (store ?f - fossil ?str - storage)
        (fetchFossilStorage ?sci - scienceOfficer ?f - fossil ?str - storage)
        (studyFossils ?sci - scienceOfficer ?f - fossil)
        (fossilStudyComp ?f - fossil)
        (collectFossils ?f - fossil)
    )

    
    (:action receive_orders
        :parameters
            (?c - captain ?n - navigator ?b - bridge ?r - region)
        :precondition
            (and
                (onBridge ?c ?b)                ;;captain and navigator are on the bridge
                (onBridge ?n ?b)
                (order ?c ?n ?r)                ;;captain orders navigator to travel to a specific underWaterRegion
            )
        :effect
            (and
                (travelTo ?n ?r)                ;;navigator receives order to travel to a specific underWaterRegion
            )
    )
    
    (:action move_sub
        :parameters
            (?s - submarine ?u - underWaterRegion ?n - navigator ?r - region ?v - vortex)
        :precondition
            (and
                (travelTo ?n ?r)                        ;;navigator receives order to travel to a specific underWaterRegion
                (not(containsVortex ?u ?v))             ;;underWaterRegion doesn't contain a vortex
            )
        :effect
            (when (and(contains ?u ?r))                 ;;underWaterRegion contains that region
                (and
                    (moveTo ?n ?s ?u)              ;;navigator moves the submarine to the underwater region which contains the region for eg: ridge
                    (location ?s ?r)                ;;sub at that region
                )
            )
            
    )

    (:action sub_at_uw_vortex
        :parameters
            (?s - submarine ?u - underWaterRegion ?n - navigator ?r - region ?v - vortex)

        :precondition
            (and
                (travelTo ?n ?r)                                    ;;navigator receives order to travel to a specific underWaterRegion
                (not(contains ?u ?r))                               ;;underWaterRegion doesn't contain that region
            )

        :effect
            (when (and (containsVortex ?u ?v))                      ;;underWaterRegion contain a vortex
                (and
                    (subAtVortexArea ?s ?v)                         ;;submarine is near that vortex area
                    (location ?s ?u)                                ;;sub at thatunderWaterRegion only
                )
            )
    )

    (:action release_drillMiniSub
        :parameters
            (?s - submarine ?e - engineer ?lb - launchBay ?dms - drillMiniSub ?r - region)
        :precondition
            (and
                (location ?s ?r)                                    ;;sub should be at that region
                (onLaunchBay ?e ?lb)                                ;;an engineer and drill minisub should be there on the launch bay. the engineer operates ths launch
                (onLaunchBayMS ?dms ?lb)
                (operateLaunch ?e)
            )
        :effect
            (and
               (not(onLaunchBayMS ?dms ?lb))                        
               (release ?dms)                                           ;;minisub released
            )
    )
    
    (:action move_miniSub
        :parameters
            (?ms - miniSub ?r - region)
        :precondition
            (and
                (release ?ms)
            )
        :effect
            (location ?ms ?r)                   ;;minisub at that region
    )

    (:action drill_miniSub
        :parameters
            (?dms - drillMiniSub ?r - region ?m - mineral)
        :precondition
            (and
                (location ?dms ?r)
                    
            )
        :effect
            (when (and(presentInRidge ?m ?r))                       ;;Minerals present in region(ridge)
                (and
                    (drill ?m)                                      ;;drill  minerals
                    (returnBack ?dms)                                   ;;then return back
                    (not(location ?dms ?r))
                )
            )
    )
    
    (:action retrieve_drillMiniSub
        :parameters
            (?e - engineer ?lb - launchBay ?dms - drillMiniSub ?r - region ?m - mineral?sci - scienceOfficer)
        :precondition
            (and
              (onLaunchBay ?e ?lb)
              (not(location ?dms ?r))
              (returnBack ?dms)
              (at ?sci ?lb)                                 ;;science officer should be present to collect the minerals
            )
        :effect
           
                    (and
                        (onLaunchBayMS ?dms ?lb)
                        (collect ?sci ?m)                               ;;collect the minerals
                    )
             
           
    )

    (:action move_to_section
        :parameters
            (?p - personnel ?ss1 - subSections ?ss2 - subSections)
        :precondition
            (and
                (at ?p ?ss1)                                                                        ;;personnel at ss1
                (or (adjacent ?ss1 ?ss2) (adjacent ?ss2 ?ss1))                                      ;;if ss1 is adjacent to ss2 or vice vera
            )
        :effect
            (and
                (not(at ?p ?ss1))
                (at ?p ?ss2)                                                                ;;personnel at ss2
            )
    )
    
    (:action study_samples
        :parameters
            (?m - mineral ?scl - sciLab ?sci1 - scienceOfficer ?sci2 - scienceOfficer)
        :precondition
            (and
               (collect ?sci1 ?m)
               (at ?sci1 ?scl)
            )
        :effect
            (and
               (when (and(presentInSubSection ?sci2 ?scl))                                  ;;science officer should be present at the sceince lab
                    (and
                        (studyMinerals ?sci2 ?m)                                                ;;study and analyse the minerals
                    )
               )
            )
    )
    
    (:action mineral_samples_study_complete
        :parameters
            (?sci - scienceOfficer ?m - mineral)
        :effect
            (when (and(studyMinerals ?sci ?m))                                                              
                (and
                    (sampleStudyComp ?m)                                             ;;study is complete after analysing the minerals       
                )            
            )
    )
    
    (:action generate_report_mineral_study
        :parameters
            (?ma - machine ?mr - mineralReport ?m - mineral ?sp - seaPort ?s - submarine)
        :precondition 
            (and 
               (not(goBackSeaport ?s ?sp)) 
            )
        
        :effect
            (when (and(sampleStudyComp ?m))                                                 
                (and
                    (generateReport ?ma ?mr)                                                ;;generate mineral report
                )            
            )
    )
    
    (:action study_vortex
        :parameters
            (?s - submarine ?u - underWaterRegion ?r - region ?v - vortex ?sci - scienceOfficer ?scl - sciLab ?ma - machine ?mr - report ?n - navigator)
        :precondition
            (and
                (or (location ?s ?r) (location ?s ?u))                                          ;;if sub is at region or underWaterRegion
                ;(contains ?u ?r)
                (or (containsVortex ?u ?v) (containsVortex ?r ?v))                                  ;;if underWaterRegion or region contains a vortex
                (or (generateReport ?ma ?mr) (subAtVortexArea ?s ?v))                                   ;;if the needed report is already generated or the submarine is at vortex area
                (not(directTo ?n ?v))                                                               ;;captain has not yet ordered navigator to move sub to vortex
            )
        :effect
            (and
               (when (and (presentInSubSection ?sci ?scl))
                    (and
                        (scan ?sci ?v)                                                          ;;start scanning the vortex
                    )
               )
            )
    )

    (:action direct_sub_to_vortex
        :parameters
            (?s - submarine ?u - underWaterRegion ?r - region ?v - vortex ?c - captain ?b - bridge ?n - navigator ?ma - machine ?mr - report ?sci - scienceOfficer)
        :precondition
            (and
                (or (location ?s ?r) (location ?s ?u))
                ;(contains ?u ?r)
                (or (containsVortex ?u ?v) (containsVortex ?r ?v))
                (or (generateReport ?ma ?mr) (subAtVortexArea ?s ?v))
                (onBridge ?c ?b)
                (onBridge ?n ?b) 
               ; (orderV ?c ?n ?v)                   
            )
        :effect
            (when (and(orderV ?c ?n ?v))                    ;;captain orders navigator to direct sub to vortex
                (and
                    (directTo ?n ?v)                 ;;navigator receives orders to direct sub to vortex
                )
            )
    )

    (:action move_sub_to_vortex
        :parameters
            (?n - navigator ?v - vortex ?s - submarine ?e - engineer ?u - underWaterRegion)
        :precondition
            (and
                (directTo ?n ?v) 
                
            )   
        :effect
            (when (and(activatedPressureShields ?e))                                    ;;pressure shields need to be activated by engineer before entering the vortex
                (and
                    (enterVortex ?s ?v)                                                 ;;sub enters vortex
                    (location ?s ?u)                                                        ;;sub is now at another underWaterRegion
                )
            )
    )
    
    (:action vortex_study_scan_complete
        :parameters
            (?sci - scienceOfficer ?v - vortex ?s - submarine ?n - navigator)
        
        :effect
            (when (and (scan ?sci ?v) (directTo ?n ?v) )
                (and
                    (vortexScanComp ?v)                             ;;scan is then complete
                )            
            )
    )
    
    (:action generate_report_vortex_study
        :parameters
            (?ma - machine ?vr - vortexReport ?v - vortex ?sp - seaPort ?s - submarine)
        :precondition 
            (and 
               (not(goBackSeaport ?s ?sp)) 
            )
        :effect
            (when (and(vortexScanComp ?v))
                (and
                    (generateReport ?ma ?vr)                        ;;generate report for vortex scan
                )            
            )
    )

    (:action release_expMiniSub
        :parameters
            (?s - submarine ?r - region ?e1 - engineer ?e2 - engineer ?lb - launchBay ?ems - expMiniSub)
        :precondition
            (and
                (not (= ?e1 ?e2)) 
                (location ?s ?r) 
                ;(contains ?u ?r)
                (onLaunchBay ?e1 ?lb)
                (onLaunchBay ?e2 ?lb)
                (onLaunchBayMS ?ems ?lb)
                (operateLaunch ?e1)
            )
        :effect
            (and
                (not(onLaunchBayMS ?ems ?lb))
                (not(onLaunchBay ?e2 ?lb)) 
                (release ?ems)
                (operateMS ?e2 ?ems)                            ;;engineer e2 operates the minisub
            )
    )

    (:action deploy_underWaterSensors
        :parameters
            (?ems - expMiniSub ?e - engineer ?sen - sensorNet ?r - region ?c - captain)
        :precondition
            (and
                (location ?ems ?r)
                (operateMS ?e ?ems)
                (not(presentInMS ?c ?ems))                                                      ;;captain should not be present in the minisub for this action
            )
        :effect
            (and
                (setUpDevice ?e ?sen)                                               ;;set up and deploy the sensors
                (deploy ?sen)
                (returnBackSen ?ems)                                        ;;return back
                (not(location ?ems ?r))
            )
    )

    (:action retrieve_exploreMiniSub
        :parameters
            (?e1 - engineer ?lb - launchBay ?ems - expMiniSub ?r - region ?e2 - engineer ?sen - sensorNet)
        :precondition
            (and
                (not (= ?e1 ?e2))
                (onLaunchBay ?e1 ?lb)
                (not(location ?ems ?r))
                (returnBackSen ?ems)
            )
        :effect
            
                    (and
                        (activateSen ?e1 ?sen)                          ;;the engineer on the launch bay completely activates the sensor
                        (onLaunchBayMS ?ems ?lb)
                    
                        (not(operateMS ?e2 ?ems))
                    
                    
                        (onLaunchBay ?e2 ?lb)
                    )
            
    )

    (:action generate_sensorNet_status_activated_report
        :parameters 
            (?ma - machine ?senr - sensorReport ?sen - sensorNet ?e - engineer?sp - seaPort ?s - submarine)
        :precondition 
            (and 
               (not(goBackSeaport ?s ?sp)) 
            )
        :effect
            (when (and(activateSen ?e ?sen))                ;;after activation generate sensor report
                (and
                    (generateReport ?ma ?senr)    
                )            
            )
    )
    
    (:action meet_leaders
        :parameters
            (?ems - expMiniSub ?e - engineer ?c - captain ?r - region ?bl - baseLeader ?se - security ?ba - baseUW)
        :precondition
            (and
                (location ?ems ?r)
                (operateMS ?e ?ems)
                (presentInMS ?c ?ems)                           ;;captain and security should be prsent in minisub
                (presentInMS ?se ?ems)
                (has ?r ?ba)                                    ;;the region (abyssal) should have a base
            )
        :effect
            (and
                (meet ?c ?bl)                                       ;;captain meets the leaders and then returns back to sub
                (returnBack ?ems)
                (not(location ?ems ?r))
            )
    )

    (:action base_underAttack
        :parameters
            (?ems - expMiniSub ?e - engineer ?c - captain ?r - region ?at - atlanteans ?ba - baseUW ?se - security)
        :precondition
            (and
                (location ?ems ?r)
                (operateMS ?e ?ems)
                (presentInMS ?c ?ems) 
                (has ?r ?ba)
               ; (takenOver ?at ?ba)                         
            )
        :effect
            (and
                (when(and (takenOver ?at ?ba) (not(presentInMS ?se ?ems)))                  ;;when base is taken over and security is not prsent in minisub captain is injured
                    (and
                        (injured ?c)
                        (returnBack ?ems)
                        (not(location ?ems ?r))
                    )
                )   
            )
    )
    
    (:action retrieve_exploreMiniSub_with_captain
        :parameters
            (?e1 - engineer ?lb - launchBay ?ems - expMiniSub ?r - region ?c - captain ?se - security ?e2 - engineer)
        :precondition
            (and
                (not (= ?e1 ?e2))
                (onLaunchBay ?e1 ?lb)
                (not(location ?ems ?r))
                (returnBack ?ems)
            )
        :effect
           ; (when(and(presentInMS ?c ?ems))
                (and
                    (onLaunchBayMS ?ems ?lb)
                    (not(presentInMS ?c ?ems))
                    (not(operateMS ?e2 ?ems))
                    (not(presentInMS ?se ?ems))
                    (at ?c ?lb)
                    (at ?se ?lb)
                    (onLaunchBay ?e2 ?lb)
                )
            ;)
    )
    
    (:action escort_injured
        :parameters
            (?se - security ?c - captain ?sb - sickBay)
        :precondition
            (and
               (at ?c ?sb) 
               (at ?se ?sb)
            )
        :effect
            (and
                (when (and (injured ?c))                            ;;security on the launch bay escorts the captain to sickbay and captain is admitted in sickbay
                    (admittedIn ?c ?sb)
                )
            )
    )
    
    (:action heal_injured
        :parameters
            (?ro - robot ?c - captain ?sb - sickBay)
        :precondition
            (and
               (robPresentIn ?ro ?sb)
            )
        :effect
            (and
                (when (and (admittedIn ?c ?sb))
                    (and
                        (operateInjured ?ro ?c)                                                 ;;only when captain is admitted the robot will treat him and captain is healed
                        (healthy ?c)
                    )
                )
            )
    )

    (:action uwbase_status_passed
        :parameters
           (?ba - baseUW ?c - captain ?bl - baseLeader ?lb - launchBay) 
    
        :effect
           (when (and(meet ?c ?bl) (at ?c ?lb))      ;;when the cap met the base leaders and the cap is back safely at the launch bay status passed
                (and
                    (statusPassed ?ba)    
                )            
            ) 
    )

    (:action generate_uwbase_status_passed_report
        :parameters 
            (?ma - machine ?br - baseReport ?ba - baseUW ?s - submarine ?sp - seaPort)
        :precondition 
            (and 
               (not(goBackSeaport ?s ?sp)) 
            )
        :effect
            (when (and(statusPassed ?ba))
                (and
                    (generateReport ?ma ?br)                ;;generate base passed report
                )            
            )
    )

    (:action uwbase_status_underattack
        :parameters
           (?ba - baseUW ?c - captain ?sb - sickBay) 
    
        :effect
           (when (and(injured ?c) (admittedIn ?c ?sb))      ;;when the captain returns injured back to the submarine, the base status is under attack
                (and
                    (statusUnderAttack ?ba)    
                )            
            ) 
    )

    (:action generate_uwbase_status_underattack_report
        :parameters 
            (?ma - machine ?br - baseReport ?ba - baseUW ?s - submarine ?sp - seaPort)

        :precondition 
            (and 
               (not(goBackSeaport ?s ?sp)) 
            )

        :effect
            (when (and(statusUnderAttack ?ba))
                (and
                    (generateReport ?ma ?br)                ;;generate base under attack report
                )            
            )
    )

    (:action collect_fossils
        :parameters
            (?ems - expMiniSub ?r - region ?e - engineer ?c - captain ?f - fossil ?de - fossilDetector ?str - storage)
        :precondition
            (and
                (location ?ems ?r)
                (operateMS ?e ?ems)
                (not(presentInMS ?c ?ems))                  ;;captain should not be present
            )
        :effect
            (when (and(fossilDetected ?f ?de))                              ;;if fossils detected then collect the fossils and store it in storage
                (and
                    (collectFossils ?f)
                    (store ?f ?str)
                    (returnBack ?ems)                           ;;return bak after done
                    (not(location ?ems ?r))
                )    
            )
    )

    (:action retrieve_exploreMiniSub_after_fossilcollection
        :parameters
            (?e1 - engineer ?e2 - engineer ?lb - launchBay ?ems - expMiniSub ?r - region ?sci - scienceOfficer ?str - storage ?f - fossil)
        :precondition
            (and
                (not (= ?e1 ?e2)) 
                (onLaunchBay ?e1 ?lb)
                (not(location ?ems ?r))
                (at ?sci ?lb)                                       ;;scienec officer is at launch bay to collect fossils
                (returnBack ?ems)
            )
        :effect
            (and                
                (onLaunchBayMS ?ems ?lb)
                (not(operateMS ?e2 ?ems))
                (onLaunchBay ?e2 ?lb) 
                (fetchFossilStorage ?sci ?f ?str)                                           ;;science officer collects fossils from storage
            )
    )

    (:action study_fossils
        :parameters
            (?sci1 - scienceOfficer ?f - fossil ?str - storage ?scl - sciLab ?sci2 - scienceOfficer)
        :precondition
            (and
               (fetchFossilStorage ?sci1 ?f ?str)
               (at ?sci1 ?scl)
            )
        :effect
            (and
               (when (and(presentInSubSection ?sci2 ?scl))
                    (and
                        (studyFossils ?sci2 ?f)                                         ;;the fossil is studied if scienec officer is present in science lab
                    )
               )
            )
    )

    (:action fossil_study_complete
        :parameters
            (?sci - scienceOfficer ?f - fossil)
        :effect
            (when (and(studyFossils ?sci ?f))
                (and
                    (fossilStudyComp ?f)                        ;afetr study the study is complete
                )            
            )
    )

    (:action generate_report_fossil_study
        :parameters
            (?ma - machine ?fr - fossilReport ?f - fossil ?s - submarine ?sp - seaPort)
        :precondition 
            (and 
               (not(goBackSeaport ?s ?sp)) 
            )
        :effect
            (when (and(fossilStudyComp ?f))
                (and
                    (generateReport ?ma ?fr)                            ;;generate report for fossil study
                )            
            )
    )

    (:action go_to_seaport
        :parameters 
            (?ma - machine ?s - submarine ?sp - seaPort)
        :effect
            (forall(?re - report)
                (when(and(generateReport ?ma ?re))
                    (and
                        (placeFolder ?re)                               ;;place all reports in a folder and go back to seaport
                        (goBackSeaport ?s ?sp)
                    )
                )
            )
    )

    (:action report_at_seaport
        :parameters 
            (?re - report ?sys - portSystem)
        :precondition 
        (and 
            (placeFolder ?re)    
        )
        :effect
            (and
                (not(placeFolder ?re))
                (atPortSystem ?re ?sys)                                         ;;the reports are finally at the port system
            )
    )

)