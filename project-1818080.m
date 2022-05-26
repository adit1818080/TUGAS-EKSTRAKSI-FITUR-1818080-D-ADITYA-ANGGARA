classdef Ember_1818080 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                 matlab.ui.Figure
        EkstraksiButton          matlab.ui.control.Button
        PerimeterEditField       matlab.ui.control.EditField
        PerimeterEditFieldLabel  matlab.ui.control.Label
        Image                    matlab.ui.control.Image
        OpenButton               matlab.ui.control.Button
        UkuranEditField          matlab.ui.control.EditField
        UkuranEditFieldLabel     matlab.ui.control.Label
        LuasEditField            matlab.ui.control.EditField
        LuasEditFieldLabel       matlab.ui.control.Label
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: OpenButton
        function OpenButtonPushed(app, event)
            [namafile, formatfile] = uigetfile({'*.jpg;*.jpeg;*.png'}, 'membuka gambar')
            global gambar
            gambar = imread([formatfile, namafile])
            app.Image.ImageSource=gambar   
            
        end

        % Button pushed function: EkstraksiButton
        function EkstraksiButtonPushed(app, event)
            global gambar
            abu = rgb2gray(gambar)                      
            thd=graythresh(abu)
            biner=im2bw(abu,thd)
            luas = bwarea(biner)  
            p= bwperim(biner)
            perimeter=bwarea(p)
            if perimeter > 4500
                ukuran='Besar'
            elseif perimeter > 3000
                ukuran='Sedang'
            else
                ukuran='Kecil'
            end
            app.LuasEditField.Value=num2str(luas)
            app.PerimeterEditField.Value=num2str(perimeter)
            app.UkuranEditField.Value=ukuran
            
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 244 423];
            app.UIFigure.Name = 'MATLAB App';

            % Create LuasEditFieldLabel
            app.LuasEditFieldLabel = uilabel(app.UIFigure);
            app.LuasEditFieldLabel.HorizontalAlignment = 'right';
            app.LuasEditFieldLabel.Position = [54 81 31 22];
            app.LuasEditFieldLabel.Text = 'Luas';

            % Create LuasEditField
            app.LuasEditField = uieditfield(app.UIFigure, 'text');
            app.LuasEditField.Editable = 'off';
            app.LuasEditField.Enable = 'off';
            app.LuasEditField.Position = [100 81 100 22];

            % Create UkuranEditFieldLabel
            app.UkuranEditFieldLabel = uilabel(app.UIFigure);
            app.UkuranEditFieldLabel.HorizontalAlignment = 'right';
            app.UkuranEditFieldLabel.Position = [41 22 44 22];
            app.UkuranEditFieldLabel.Text = 'Ukuran';

            % Create UkuranEditField
            app.UkuranEditField = uieditfield(app.UIFigure, 'text');
            app.UkuranEditField.Editable = 'off';
            app.UkuranEditField.Enable = 'off';
            app.UkuranEditField.Position = [100 22 100 22];

            % Create OpenButton
            app.OpenButton = uibutton(app.UIFigure, 'push');
            app.OpenButton.ButtonPushedFcn = createCallbackFcn(app, @OpenButtonPushed, true);
            app.OpenButton.Position = [43 150 159 23];
            app.OpenButton.Text = 'Open';

            % Create Image
            app.Image = uiimage(app.UIFigure);
            app.Image.Position = [16 193 212 211];

            % Create PerimeterEditFieldLabel
            app.PerimeterEditFieldLabel = uilabel(app.UIFigure);
            app.PerimeterEditFieldLabel.HorizontalAlignment = 'right';
            app.PerimeterEditFieldLabel.Position = [28 52 57 22];
            app.PerimeterEditFieldLabel.Text = 'Perimeter';

            % Create PerimeterEditField
            app.PerimeterEditField = uieditfield(app.UIFigure, 'text');
            app.PerimeterEditField.Editable = 'off';
            app.PerimeterEditField.Enable = 'off';
            app.PerimeterEditField.Position = [100 52 100 22];

            % Create EkstraksiButton
            app.EkstraksiButton = uibutton(app.UIFigure, 'push');
            app.EkstraksiButton.ButtonPushedFcn = createCallbackFcn(app, @EkstraksiButtonPushed, true);
            app.EkstraksiButton.Position = [43 122 159 23];
            app.EkstraksiButton.Text = 'Ekstraksi';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Ember_1818080

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end