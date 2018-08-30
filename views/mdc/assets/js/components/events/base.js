import {VErrors} from './errors';
import {VUrls} from '../../utils/urls';

export class VBase extends VUrls {
    constructor(options) {
        super();
        this.options = options;
    }

    clearErrors() {
        new VErrors().clearErrors();
    }

    parentElement() {
        return document.getElementById(this.options.__parent_id__);
    }

    inputComponents(el) {
        return el.querySelectorAll('.v-input')
    }

    inputValues(form) {
        let params = [];

        if(this.params.input_tag !== undefined){
            var inputContainers = document.querySelectorAll('[data-input-tag=' + this.params.input_tag + ']');
            for (let container of inputContainers) {
                for (let input of this.inputComponents(container)) {
                    if (input.vComponent && typeof input.vComponent.prepareSubmit === 'function') {
                        input.vComponent.prepareSubmit(params);
                    }
                }
            }
        }
        else
        {
            // Let input components push parameters
            let vComp = this.component();
            if (vComp) {
                vComp.prepareSubmit(params);
            }
        }
        return params;
    }

    component() {
        let parent = this.parentElement();
        return parent ? parent.vComponent : null;
    }

    validate() {
        let errors = [];
        let comp = this.component();
        if (comp) {
            errors = comp.validate();
        }
        return errors;
    }
}
