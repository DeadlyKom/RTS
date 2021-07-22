
                ifndef _CORE_GAME_LOOP_
                define _CORE_GAME_LOOP_
GameLoop:       
                ; add unit
                SeMemoryPage MemoryPage_Tilemap, DRAFT_INIT_ID

                ; JR $

                ;
                CALL Utils.WaypointsSequencer.Create
                JR C, $

                ; 1
                LD DE, #0C0A
                CALL Utils.WaypointsSequencer.AddWaypoint
                JR NC, $
                ; 2
                LD DE, #0D0D
                CALL Utils.WaypointsSequencer.AddWaypoint
                JR NC, $
                ; 3
                LD DE, #110F
                CALL Utils.WaypointsSequencer.AddWaypoint
                JR NC, $
                ; 4
                LD DE, #150D
                CALL Utils.WaypointsSequencer.AddWaypoint
                JR NC, $
                ; 5
                LD DE, #1306
                CALL Utils.WaypointsSequencer.AddWaypoint
                JR NC, $
                ; 6
                LD DE, #0D06
                CALL Utils.WaypointsSequencer.AddWaypoint
                JR NC, $

                ; spawn unit
                LD BC, #0202
                CALL Spawn.Unit

                LD A, IXL
                LD C, FUTF_VALID_IDX | FUTF_INSERT | FUTF_LOOP | FUTF_MASK_OFFSET         ;%01110111                  ; бит FUTF_VALID = 0 (не валидный WayPoint)
                CALL Utils.WaypointsSequencer.AddUnit

                ; spawn unit
                LD BC, #0506
                CALL Spawn.Unit

                LD A, IXL
                LD C, FUTF_VALID_IDX | FUTF_INSERT | FUTF_LOOP | 6         ;%01110111                  ; бит FUTF_VALID = 0 (не валидный WayPoint)
                CALL Utils.WaypointsSequencer.AddUnit

                ; spawn unit
                LD BC, #080A
                CALL Spawn.Unit

                LD A, IXL
                LD C, FUTF_VALID_IDX | FUTF_INSERT | FUTF_LOOP | 5         ;%01110111                  ; бит FUTF_VALID = 0 (не валидный WayPoint)
                CALL Utils.WaypointsSequencer.AddUnit

                ; spawn unit
                LD BC, #0A06
                CALL Spawn.Unit

                LD A, IXL
                LD C, FUTF_VALID_IDX | FUTF_INSERT | FUTF_LOOP | 3         ;%01110111                  ; бит FUTF_VALID = 0 (не валидный WayPoint)
                CALL Utils.WaypointsSequencer.AddUnit

.MainLoop       BEGIN_DEBUG_BORDER_DEF
                
                CheckGameplayFlag PATHFINDING_FLAG
                CALL Z, Pathfinding.Begin

                CheckFrameFlag SWAP_SCREENS_FLAG
                JR Z, .MainLoop

.Render         ; ************ RENDER ************      

                ; toggle to memory page with tile sprites
                SeMemoryPage MemoryPage_ShadowScreen, RENDER_BEGIN_ID
                SetFrameFlag ALLOW_MOVE_TILEMAP

.Tilemap        ; ************ TILEMAP ************
                ; show debug border
                ifdef SHOW_DEBUG_BORDER_TILEMAP
                BEGIN_DEBUG_BORDER_COL RENDER_TILEMAP_COLOR
                endif

                CALL Tilemap.Display

                ; ~ TILEMAP

.Unit           ; ********** DRAW UNITS ***********
                ; show debug border
                ifdef SHOW_DEBUG_BORDER_DRAW_UNITS
                BEGIN_DEBUG_BORDER_COL RENDER_UNITS_COLOR
                endif

                CALL Unit.Handler

                ; ~ DRAW UNITS

                ; ---------------------------------
                ; toggle to memory page with tile sprites
                SeMemoryPage MemoryPage_ShadowScreen, RENDER_FOW_BEGIN_ID
                
.FOW            ; ************** FOW **************
                ifdef ENABLE_FOW
                ; show debug border
                ifdef SHOW_DEBUG_BORDER_FOW
                BEGIN_DEBUG_BORDER_COL RENDER_FOW_COLOR
                endif
                
                CALL Tilemap.FOW

                endif
                ; ~ FOW

.CompliteFlags  ; ************* FLAGS *************
                CheckGameplayFlag PATHFINDING_FLAG                      ; пропустим если необходимо посчитать путь
                JR Z, .Logic
                ResetFrameFlag SWAP_SCREENS_FLAG
                ; ~ FLAGS

                ; ~ RENDER

.Logic          ; ************* LOGIC *************
                ; show debug border
                ifdef SHOW_DEBUG_BORDER_DRAFT_LOGIC
                BEGIN_DEBUG_BORDER_COL DRAFT_LOGIC_COLOR
                endif

                CheckAIFlag (AI_UPDATE_FLAG | GAME_PAUSE_FLAG)
                CALL Z, AI.Handler
                
                JP .MainLoop

                endif ; ~_CORE_GAME_LOOP_
